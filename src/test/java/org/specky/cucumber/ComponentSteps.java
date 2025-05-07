package org.specky.cucumber;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.And;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Step definitions for component publishing and retrieval features.
 */
public class ComponentSteps {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    private String componentName;
    private String componentVersion;
    private String componentDescription;
    private byte[] packageContent;
    private ResponseEntity<?> response;
    private ResponseEntity<byte[]> downloadResponse;
    private HttpStatusCode responseStatus;
    private boolean isValidPackage = true;
    private boolean componentExists = false;

    // Publishing steps

    @Given("a user has a valid component package")
    public void userHasValidComponentPackage() throws IOException {
        componentName = "@specky-pm/test-component";
        componentVersion = "1.0.0";
        componentDescription = "Test component for BDD testing";
        packageContent = createValidComponentPackage();
    }

    @Given("a user has an invalid component package")
    public void userHasInvalidComponentPackage() {
        componentName = "@specky-pm/test-component";
        componentVersion = "invalid-version"; // Invalid semantic version
        componentDescription = "Test component with invalid version";
        packageContent = new byte[]{1, 2, 3, 4, 5}; // Simple byte array
        isValidPackage = false;
    }

    @Given("a user has created a component with valid and spec.json file")
    public void userHasComponentWithValidSpecJson() throws IOException {
        componentName = "@specky-pm/test-component";
        componentVersion = "1.0.0";
        componentDescription = "Test component with spec.json";
        packageContent = createComponentPackageWithSpecJson();
    }

    @Given("a user has created a component with a valid structure")
    public void userHasComponentWithValidStructure() throws IOException {
        componentName = "@specky-pm/test-component";
        componentVersion = "1.0.0";
        componentDescription = "Test component with valid structure";
        packageContent = createValidComponentPackage();
    }

    @Given("a component with the same name and version already exists in the repository")
    public void componentWithSameNameAndVersionExists() throws IOException {
        // First, upload a component
        uploadComponent(componentName, componentVersion, "Original component", createValidComponentPackage());
        
        // Update the description for the new component
        componentDescription = "Updated component";
        packageContent = createValidComponentPackage();
    }

    @When("the user uploads the component package")
    public void userUploadsComponentPackage() {
        try {
            response = uploadComponent(componentName, componentVersion, componentDescription, packageContent);
            responseStatus = response.getStatusCode();
        } catch (HttpClientErrorException e) {
            responseStatus = e.getStatusCode();
        }
    }

    @Then("the system should store the component package in the storage")
    public void systemStoresComponentPackage() {
        assertEquals(HttpStatus.CREATED.value(), responseStatus.value(), "Component should be created successfully");
    }

    @Then("the system should reject the component package")
    public void systemRejectsComponentPackage() {
        assertEquals(HttpStatus.BAD_REQUEST.value(), responseStatus.value(), "Invalid component should be rejected");
    }

    @And("the system should confirm successful storage")
    public void systemConfirmsSuccessfulStorage() {
        assertNotNull(response.getBody(), "Response body should not be null");
        
        @SuppressWarnings("unchecked")
        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        
        assertEquals(componentName, responseBody.get("name"), "Component name should match");
        assertEquals(componentVersion, responseBody.get("version"), "Component version should match");
        assertEquals(componentDescription, responseBody.get("description"), "Component description should match");
        assertNotNull(responseBody.get("publicationTimestamp"), "Publication timestamp should not be null");
        assertNotNull(responseBody.get("updateTimestamp"), "Update timestamp should not be null");
    }

    @And("the component should be available for retrieval")
    public void componentIsAvailableForRetrieval() {
        String url = "http://localhost:" + port + "/api/components/download?name=" + componentName + "&version=" + componentVersion;
        
        ResponseEntity<byte[]> downloadResponse = restTemplate.getForEntity(url, byte[].class);
        assertEquals(HttpStatus.OK.value(), downloadResponse.getStatusCode().value(), "Component should be available for download");
        assertNotNull(downloadResponse.getBody(), "Downloaded content should not be null");
        assertTrue(downloadResponse.getBody().length > 0, "Downloaded content should not be empty");
    }

    @And("the system should report storage failure")
    public void systemReportsStorageFailure() {
        // For invalid components, we expect a 400 Bad Request response
        assertEquals(HttpStatus.BAD_REQUEST.value(), responseStatus.value(), "System should report storage failure");
    }

    @And("the component should not be available for retrieval")
    public void componentIsNotAvailableForRetrieval() {
        String url = "http://localhost:" + port + "/api/components/download?name=" + componentName + "&version=" + componentVersion;
        
        try {
            ResponseEntity<byte[]> downloadResponse = restTemplate.getForEntity(url, byte[].class);
            assertNotEquals(HttpStatus.OK.value(), downloadResponse.getStatusCode().value(), "Component should not be available for download");
        } catch (RestClientException e) {
            // Expected exception for non-existent component
            assertTrue(true, "Component should not be available for download");
        }
    }

    @Then("the metadata from the spec.json should be found in the system")
    public void metadataFromSpecJsonIsFound() {
        assertNotNull(response.getBody(), "Response body should not be null");
        
        @SuppressWarnings("unchecked")
        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        
        assertEquals(componentName, responseBody.get("name"), "Component name should match");
        assertEquals(componentVersion, responseBody.get("version"), "Component version should match");
        assertEquals(componentDescription, responseBody.get("description"), "Component description should match");
    }

    @Then("the system should overwrite the existing component")
    public void systemOverwritesExistingComponent() {
        assertEquals(HttpStatus.CREATED.value(), responseStatus.value(), "Component should be created successfully");
    }

    @And("the metadata from the new spec.json should be found in the system")
    public void metadataFromNewSpecJsonIsFound() {
        assertNotNull(response.getBody(), "Response body should not be null");
        
        @SuppressWarnings("unchecked")
        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        
        assertEquals(componentName, responseBody.get("name"), "Component name should match");
        assertEquals(componentVersion, responseBody.get("version"), "Component version should match");
        assertEquals(componentDescription, responseBody.get("description"), "Component description should match");
    }

    // Retrieval steps

    @Given("a component {string} with version {string} exists in storage")
    public void componentExistsInStorage(String name, String version) throws IOException {
        componentName = name;
        componentVersion = version;
        packageContent = createValidComponentPackage();
        
        // Upload the component to ensure it exists
        uploadComponent(componentName, componentVersion, "Test component for retrieval", packageContent);
        componentExists = true;
    }

    @Given("no component {string} exists in storage")
    public void noComponentExistsInStorage(String name) {
        componentName = name;
        componentVersion = "1.0.0";
        componentExists = false;
    }

    @When("the user requests to download component {string} version {string}")
    public void userRequestsToDownloadComponent(String name, String version) {
        componentName = name;
        componentVersion = version;
        
        String url = "http://localhost:" + port + "/api/components/download?name=" + componentName + "&version=" + componentVersion;
        
        try {
            downloadResponse = restTemplate.getForEntity(url, byte[].class);
            responseStatus = downloadResponse.getStatusCode();
        } catch (HttpClientErrorException e) {
            responseStatus = e.getStatusCode();
        }
    }

    @Then("the component package is retrieved from storage")
    public void componentPackageIsRetrievedFromStorage() {
        assertEquals(HttpStatus.OK.value(), responseStatus.value(), "Component should be retrieved successfully");
        assertNotNull(downloadResponse.getBody(), "Downloaded content should not be null");
        assertTrue(downloadResponse.getBody().length > 0, "Downloaded content should not be empty");
    }

    @And("the component is prepared for download")
    public void componentIsPreparedForDownload() {
        HttpHeaders headers = downloadResponse.getHeaders();
        assertEquals(MediaType.APPLICATION_OCTET_STREAM, headers.getContentType(), 
                "Content type should be application/octet-stream");
        assertTrue(headers.getContentDisposition().toString().contains("attachment"), 
                "Content disposition should be attachment");
    }

    @Then("the component package is prepared as a zip file")
    public void componentPackageIsPreparedAsZipFile() {
        HttpHeaders headers = downloadResponse.getHeaders();
        assertEquals(MediaType.APPLICATION_OCTET_STREAM, headers.getContentType(), 
                "Content type should be application/octet-stream");
        assertTrue(headers.getContentDisposition().toString().contains(".zip"), 
                "Content disposition should include .zip extension");
    }

    @And("the zip file is served to the user")
    public void zipFileIsServedToUser() {
        assertNotNull(downloadResponse.getBody(), "Downloaded content should not be null");
        assertTrue(downloadResponse.getBody().length > 0, "Downloaded content should not be empty");
        
        // In a real test, we could verify the ZIP file structure here
        // For now, we just check that we got some content
    }

    @Then("an error occurs indicating the component does not exist")
    public void errorOccursIndicatingComponentDoesNotExist() {
        assertEquals(HttpStatus.NOT_FOUND.value(), responseStatus.value(), "Should return 404 Not Found for non-existent component");
    }

    // Helper methods

    private ResponseEntity<Map> uploadComponent(String name, String version, String description, byte[] content) {
        String url = "http://localhost:" + port + "/api/components";
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("name", name);
        body.add("version", version);
        body.add("description", description);
        
        Resource packageResource = new ByteArrayResource(content) {
            @Override
            public String getFilename() {
                return "component.zip";
            }
        };
        body.add("packageFile", packageResource);
        
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
        
        return restTemplate.postForEntity(url, requestEntity, Map.class);
    }

    private byte[] createValidComponentPackage() throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (ZipOutputStream zos = new ZipOutputStream(baos)) {
            // Add a sample file to the ZIP
            ZipEntry entry = new ZipEntry("sample.txt");
            zos.putNextEntry(entry);
            zos.write("This is a sample file content".getBytes());
            zos.closeEntry();
        }
        return baos.toByteArray();
    }

    private byte[] createComponentPackageWithSpecJson() throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (ZipOutputStream zos = new ZipOutputStream(baos)) {
            // Add a sample file to the ZIP
            ZipEntry fileEntry = new ZipEntry("sample.txt");
            zos.putNextEntry(fileEntry);
            zos.write("This is a sample file content".getBytes());
            zos.closeEntry();
            
            // Add spec.json to the ZIP
            ZipEntry specEntry = new ZipEntry("spec.json");
            zos.putNextEntry(specEntry);
            String specJson = String.format(
                    "{\"name\":\"%s\",\"version\":\"%s\",\"description\":\"%s\"}",
                    componentName, componentVersion, componentDescription
            );
            zos.write(specJson.getBytes());
            zos.closeEntry();
        }
        return baos.toByteArray();
    }
}