package org.specky.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.specky.dto.ComponentDTO;
import org.specky.dto.ComponentListResponse;
import org.specky.dto.ComponentUploadRequest;
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
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ComponentDTO> uploadComponent(
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
     * @param request The HTTP request
     * @return ResponseEntity with the component package as a byte array
     */
    @GetMapping("/download")
    public ResponseEntity<byte[]> downloadComponent(
            @RequestParam String name, @RequestParam String version) {
        
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
    @GetMapping("/versions")
    public ResponseEntity<ComponentListResponse> listComponentVersions(@RequestParam String name) {
        logger.info("Received request to list versions for component: {}", name);
        
        List<Component> components = componentService.getComponentVersions(name);
        ComponentListResponse response = componentMapper.toListResponse(components);
        
        return ResponseEntity.ok(response);
    }
}