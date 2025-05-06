package org.specky.mapper;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.specky.dto.ComponentDTO;
import org.specky.dto.ComponentListResponse;
import org.specky.dto.ComponentUploadRequest;
import org.specky.model.Component;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Mapper class for converting between Component entities and DTOs.
 * Uses Spring's ObjectMapper for efficient object mapping.
 */
@Service
@RequiredArgsConstructor
public class ComponentMapper {

    private final ObjectMapper objectMapper;

    /**
     * Converts a Component entity to a ComponentDTO.
     *
     * @param component The Component entity
     * @return The ComponentDTO
     */
    public ComponentDTO toDTO(Component component) {
        return objectMapper.convertValue(component, ComponentDTO.class);
    }
    
    /**
     * Converts a list of Component entities to a ComponentListResponse.
     *
     * @param components The list of Component entities
     * @return The ComponentListResponse
     */
    public ComponentListResponse toListResponse(List<Component> components) {
        List<ComponentDTO> componentDTOs = components.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
        
        return ComponentListResponse.builder()
                .count(componentDTOs.size())
                .components(componentDTOs)
                .build();
    }
    
    /**
     * Converts a ComponentUploadRequest to a Component entity.
     * Handles the special case of reading the package file bytes.
     *
     * @param request The ComponentUploadRequest
     * @return The Component entity
     * @throws IOException If there's an error reading the package file
     */
    public Component toEntity(ComponentUploadRequest request) throws IOException {
        Component component = Component.builder()
                .name(request.getName())
                .version(request.getVersion())
                .description(request.getDescription())
                .packageContent(request.getPackageFile().getBytes())
                .build();
                
        return component;
    }
}