package org.specky.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Data Transfer Object for Component information.
 * Used for API responses when returning component metadata.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ComponentDTO {
    private String name;
    private String version;
    private String description;
    private LocalDateTime publicationTimestamp;
    private LocalDateTime updateTimestamp;
    
    // Package content is intentionally excluded from the DTO
    // to avoid transferring large binary data in metadata responses
}