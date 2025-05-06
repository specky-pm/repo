package org.specky.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Data Transfer Object for component list responses.
 * Used when returning lists of components or component versions.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ComponentListResponse {
    
    /**
     * Total number of components in the response
     */
    private int count;
    
    /**
     * List of component DTOs
     */
    private List<ComponentDTO> components;
}