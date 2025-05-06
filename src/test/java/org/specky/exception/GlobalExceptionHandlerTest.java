package org.specky.exception;

import org.junit.jupiter.api.Test;
import org.specky.service.exception.ComponentNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for the GlobalExceptionHandler.
 * Tests error handling for various API endpoints.
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@Transactional
public class GlobalExceptionHandlerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testComponentNotFoundException() throws Exception {
        // Test getting a component that doesn't exist
        mockMvc.perform(get("/api/components/download")
                .param("name", "@specky/non-existent")
                .param("version", "1.0.0"))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.status", is(404)))
                .andExpect(jsonPath("$.message", is("Component not found")))
                .andExpect(jsonPath("$.details", is("Component @specky/non-existent with version 1.0.0 not found")))
                .andExpect(jsonPath("$.timestamp", notNullValue()))
                .andExpect(jsonPath("$.path", is("/api/components/download")));
    }

    @Test
    public void testValidationException() throws Exception {
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
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.status", is(400)))
                .andExpect(jsonPath("$.message", is("Invalid request")))
                .andExpect(jsonPath("$.timestamp", notNullValue()))
                .andExpect(jsonPath("$.path", is("/api/components")));
    }

    @Test
    public void testMissingRequiredParameter() throws Exception {
        // Create a test component package
        MockMultipartFile packageFile = new MockMultipartFile(
                "packageFile",
                "test-component.zip",
                MediaType.APPLICATION_OCTET_STREAM_VALUE,
                "test package content".getBytes()
        );

        // Upload without required name parameter
        mockMvc.perform(multipart("/api/components")
                .file(packageFile)
                .param("version", "1.0.0")
                .param("description", "Test component"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.status", is(400)))
                .andExpect(jsonPath("$.message", is("Invalid request")))
                .andExpect(jsonPath("$.timestamp", notNullValue()))
                .andExpect(jsonPath("$.path", is("/api/components")));
    }
}