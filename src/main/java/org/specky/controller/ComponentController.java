package org.specky.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.specky.dto.ComponentDTO;
import org.specky.dto.ComponentListResponse;
import org.specky.dto.ComponentUploadRequest;
import org.specky.dto.ErrorResponse;
import org.specky.mapper.ComponentMapper;
import org.specky.model.Component;
import org.specky.service.ComponentService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

/**
 * REST controller for component operations.
 * Provides endpoints for uploading, downloading, and listing components.
 */
@Tag(name = "Component API", description = "API for managing Specky components")
@RestController
@RequestMapping("/api/components")
@RequiredArgsConstructor
public class ComponentController {

    private static final Logger logger = LoggerFactory.getLogger(ComponentController.class);
    
    private final ComponentService componentService;
    private final ComponentMapper componentMapper;
    
    /**
     * Uploads a new component.
     *
     * @param request The component upload request
     * @return ResponseEntity with the uploaded component information
     * @throws IOException If there's an error reading the package file
     */
    @Operation(
        summary = "Upload a new component",
        description = "Uploads a new component package to the repository. If a component with the same name and version already exists, it will be overwritten."
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "201", description = "Component successfully uploaded",
                    content = @Content(schema = @Schema(implementation = ComponentDTO.class))),
        @ApiResponse(responseCode = "400", description = "Invalid request data",
                    content = @Content(schema = @Schema(implementation = ErrorResponse.class))),
        @ApiResponse(responseCode = "500", description = "Internal server error",
                    content = @Content(schema = @Schema(implementation = ErrorResponse.class)))
    })
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ComponentDTO> uploadComponent(
            @Parameter(description = "Component upload request containing name, version, description, and package file")
            @Valid @ModelAttribute ComponentUploadRequest request) throws IOException {
        
        logger.info("Received request to upload component: {} version {}", 
                request.getName(), request.getVersion());
        
        Component component = componentMapper.toEntity(request);
        Component savedComponent = componentService.uploadComponent(component);
        ComponentDTO responseDTO = componentMapper.toDTO(savedComponent);
        
        return ResponseEntity.status(HttpStatus.CREATED).body(responseDTO);
    }
    
    /**
     * Downloads a specific component version.
     *
     * @param name The component name
     * @param version The component version
     * @return ResponseEntity with the component package as a byte array
     */
    @Operation(
        summary = "Download a component",
        description = "Downloads a specific component version as a ZIP file"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Component successfully downloaded",
                    content = @Content(mediaType = "application/octet-stream")),
        @ApiResponse(responseCode = "404", description = "Component not found",
                    content = @Content(schema = @Schema(implementation = ErrorResponse.class))),
        @ApiResponse(responseCode = "500", description = "Internal server error",
                    content = @Content(schema = @Schema(implementation = ErrorResponse.class)))
    })
    @GetMapping("/download")
    public ResponseEntity<byte[]> downloadComponent(
            @Parameter(description = "Component name, e.g. @specky-pm/component-storage") @RequestParam String name,
            @Parameter(description = "Component version, e.g. 1.0.0") @RequestParam String version) {
        
        logger.info("Received request to download component: {} version {}", name, version);
        
        Component component = componentService.getComponent(name, version);
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", 
                name.replace("/", "-") + "-" + version + ".zip");
        
        return new ResponseEntity<>(component.getPackageContent(), headers, HttpStatus.OK);
    }
    
    /**
     * Lists all available components.
     *
     * @return ResponseEntity with the list of components
     */
    @Operation(
        summary = "List all components",
        description = "Returns a list of all components available in the repository"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Components successfully retrieved",
                    content = @Content(schema = @Schema(implementation = ComponentListResponse.class))),
        @ApiResponse(responseCode = "500", description = "Internal server error",
                    content = @Content(schema = @Schema(implementation = ErrorResponse.class)))
    })
    @GetMapping
    public ResponseEntity<ComponentListResponse> listComponents() {
        logger.info("Received request to list all components");
        
        List<Component> components = componentService.getAllComponents();
        ComponentListResponse response = componentMapper.toListResponse(components);
        
        return ResponseEntity.ok(response);
    }
    
    /**
     * Lists all versions of a specific component.
     *
     * @param name The component name
     * @return ResponseEntity with the list of component versions
     */
    @Operation(
        summary = "List component versions",
        description = "Returns a list of all available versions for a specific component"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Component versions successfully retrieved",
                    content = @Content(schema = @Schema(implementation = ComponentListResponse.class))),
        @ApiResponse(responseCode = "404", description = "Component not found",
                    content = @Content(schema = @Schema(implementation = ErrorResponse.class))),
        @ApiResponse(responseCode = "500", description = "Internal server error",
                    content = @Content(schema = @Schema(implementation = ErrorResponse.class)))
    })
    @GetMapping("/versions")
    public ResponseEntity<ComponentListResponse> listComponentVersions(
            @Parameter(description = "Component name, e.g. @specky-pm/component-storage") @RequestParam String name) {
        logger.info("Received request to list versions for component: {}", name);
        
        List<Component> components = componentService.getComponentVersions(name);
        ComponentListResponse response = componentMapper.toListResponse(components);
        
        return ResponseEntity.ok(response);
    }
}