package org.specky.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

/**
 * Data Transfer Object for component upload requests.
 * Used to validate and transfer component upload data from the client.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ComponentUploadRequest {
    
    /**
     * Component name, typically in the format @organization/name
     * Example: @specky/component-storage
     */
    @NotBlank(message = "Component name is required")
    private String name;
    
    /**
     * Component version following semantic versioning (major.minor.patch)
     */
    @NotBlank(message = "Component version is required")
    @Pattern(regexp = "^\\d+\\.\\d+\\.\\d+$", 
             message = "Version must follow semantic versioning format (e.g., 1.2.3)")
    private String version;
    
    /**
     * Description of the component's purpose and functionality
     */
    private String description;
    
    /**
     * The component package file (ZIP file)
     */
    @NotNull(message = "Component package file is required")
    private MultipartFile packageFile;
}