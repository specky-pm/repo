package org.specky.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for the ComponentController.
 * Uses a real H2 database to test the entire API flow end-to-end.
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@Transactional
public class ComponentControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testUploadComponent() throws Exception {
        // Create a test component package
        MockMultipartFile packageFile = new MockMultipartFile(
                "packageFile",
                "test-component.zip",
                MediaType.APPLICATION_OCTET_STREAM_VALUE,
                "test package content".getBytes()
        );

        // Upload the component
        mockMvc.perform(multipart("/api/components")
                .file(packageFile)
                .param("name", "@specky/test-component")
                .param("version", "1.0.0")
                .param("description", "Test component"))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name", is("@specky/test-component")))
                .andExpect(jsonPath("$.version", is("1.0.0")))
                .andExpect(jsonPath("$.description", is("Test component")))
                .andExpect(jsonPath("$.publicationTimestamp", notNullValue()))
                .andExpect(jsonPath("$.updateTimestamp", notNullValue()));
    }

    @Test
    public void testGetAllComponents_EmptyRepository() throws Exception {
        // Test getting all components when repository is empty
        mockMvc.perform(get("/api/components"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.count", is(0)))
                .andExpect(jsonPath("$.components", hasSize(0)));
    }

    @Test
    public void testUploadAndGetComponent() throws Exception {
        // Create and upload a test component
        MockMultipartFile packageFile = new MockMultipartFile(
                "packageFile",
                "test-component.zip",
                MediaType.APPLICATION_OCTET_STREAM_VALUE,
                "test package content".getBytes()
        );

        // Upload the component
        mockMvc.perform(multipart("/api/components")
                .file(packageFile)
                .param("name", "@specky/test-component")
                .param("version", "1.0.0")
                .param("description", "Test component"))
                .andExpect(status().isCreated());

        // Get the component by name and version
        MvcResult result = mockMvc.perform(get("/api/components/download")
                .param("name", "@specky/test-component")
                .param("version", "1.0.0"))
                .andExpect(status().isOk())
                .andExpect(header().string("Content-Type", MediaType.APPLICATION_OCTET_STREAM_VALUE))
                .andExpect(header().string("Content-Disposition", containsString("attachment")))
                .andReturn();

        // Verify the content
        byte[] content = result.getResponse().getContentAsByteArray();
        String contentString = new String(content);
        assert contentString.equals("test package content");
    }

    @Test
    public void testGetAllComponents_WithComponents() throws Exception {
        // Create and upload test components
        MockMultipartFile packageFile1 = new MockMultipartFile(
                "packageFile",
                "test-component1.zip",
                MediaType.APPLICATION_OCTET_STREAM_VALUE,
                "test package content 1".getBytes()
        );

        MockMultipartFile packageFile2 = new MockMultipartFile(
                "packageFile",
                "test-component2.zip",
                MediaType.APPLICATION_OCTET_STREAM_VALUE,
                "test package content 2".getBytes()
        );

        // Upload the components
        mockMvc.perform(multipart("/api/components")
                .file(packageFile1)
                .param("name", "@specky/test-component1")
                .param("version", "1.0.0")
                .param("description", "Test component 1"))
                .andExpect(status().isCreated());

        mockMvc.perform(multipart("/api/components")
                .file(packageFile2)
                .param("name", "@specky/test-component2")
                .param("version", "1.0.0")
                .param("description", "Test component 2"))
                .andExpect(status().isCreated());

        // Get all components
        mockMvc.perform(get("/api/components"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.count", is(2)))
                .andExpect(jsonPath("$.components", hasSize(2)))
                .andExpect(jsonPath("$.components[*].name", containsInAnyOrder(
                        "@specky/test-component1", "@specky/test-component2")));
    }

    @Test
    public void testGetComponentVersions() throws Exception {
        // Create and upload multiple versions of a component
        MockMultipartFile packageFile1 = new MockMultipartFile(
                "packageFile",
                "test-component-v1.zip",
                MediaType.APPLICATION_OCTET_STREAM_VALUE,
                "test package content v1".getBytes()
        );

        MockMultipartFile packageFile2 = new MockMultipartFile(
                "packageFile",
                "test-component-v2.zip",
                MediaType.APPLICATION_OCTET_STREAM_VALUE,
                "test package content v2".getBytes()
        );

        // Upload the components
        mockMvc.perform(multipart("/api/components")
                .file(packageFile1)
                .param("name", "@specky/test-component")
                .param("version", "1.0.0")
                .param("description", "Test component v1"))
                .andExpect(status().isCreated());

        mockMvc.perform(multipart("/api/components")
                .file(packageFile2)
                .param("name", "@specky/test-component")
                .param("version", "1.1.0")
                .param("description", "Test component v2"))
                .andExpect(status().isCreated());

        // Get all versions of the component
        mockMvc.perform(get("/api/components/versions")
                .param("name", "@specky/test-component"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.count", is(2)))
                .andExpect(jsonPath("$.components", hasSize(2)))
                .andExpect(jsonPath("$.components[*].version", containsInAnyOrder("1.0.0", "1.1.0")));
    }

    @Test
    public void testGetNonExistentComponent() throws Exception {
        // Test getting a component that doesn't exist
        mockMvc.perform(get("/api/components/download")
                .param("name", "@specky/non-existent")
                .param("version", "1.0.0"))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.status", is(404)))
                .andExpect(jsonPath("$.message", is("Component not found")));
    }

    @Test
    public void testGetNonExistentComponentVersions() throws Exception {
        // Test getting versions of a component that doesn't exist
        mockMvc.perform(get("/api/components/versions")
                .param("name", "@specky/non-existent"))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.status", is(404)))
                .andExpect(jsonPath("$.message", is("Component not found")));
    }

    @Test
    public void testUploadInvalidComponent() throws Exception {
        // Create a test component package
        MockMultipartFile packageFile = new MockMultipartFile(
                "packageFile",
                "test-component.zip",
                MediaType.APPLICATION_OCTET_STREAM_VALUE,
                "test package content".getBytes()
        );

        // Upload with invalid version format
        mockMvc.perform(multipart("/api/components")
                .file(packageFile)
                .param("name", "@specky/test-component")
                .param("version", "invalid-version")
                .param("description", "Test component"))
                .andExpect(status().isBadRequest());
    }
}