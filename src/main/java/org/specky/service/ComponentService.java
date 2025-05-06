package org.specky.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.specky.model.Component;
import org.specky.repository.ComponentRepository;
import org.specky.service.exception.ComponentNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Service for managing component operations including upload, retrieval, and version management.
 * Implements business logic for the Specky Repository.
 */
@Service
public class ComponentService {

    private static final Logger logger = LoggerFactory.getLogger(ComponentService.class);
    
    // Using a lock for concurrent operations on the same component
    private final ReentrantLock componentLock = new ReentrantLock();
    
    private final ComponentRepository componentRepository;
    
    @Value("${specky.component.max-size:10485760}") // Default 10MB
    private long maxPackageSize;

    @Autowired
    public ComponentService(ComponentRepository componentRepository) {
        this.componentRepository = componentRepository;
    }

    /**
     * Uploads a new component to the repository.
     * If a component with the same name and version already exists, it will be overwritten.
     *
     * @param component The component to upload
     * @return The saved component
     */
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public Component uploadComponent(Component component) {
        logger.info("Uploading component: {} version {}", component.getName(), component.getVersion());
        
        try {
            // Acquire lock for this component to prevent concurrent modifications
            componentLock.lock();
            
            // Check if component already exists
            boolean exists = componentRepository.existsByNameAndVersion(component.getName(), component.getVersion());
            
            // Set timestamps
            LocalDateTime now = LocalDateTime.now();
            if (exists) {
                logger.info("Component {} version {} already exists, overwriting", component.getName(), component.getVersion());
                // Find existing component to preserve publication timestamp
                Component existingComponent = componentRepository.findByNameAndVersion(component.getName(), component.getVersion())
                        .orElseThrow(() -> new ComponentNotFoundException(
                                "Component " + component.getName() + " with version " + component.getVersion() + " not found"));
                component.setPublicationTimestamp(existingComponent.getPublicationTimestamp());
                component.setUpdateTimestamp(now);
            } else {
                component.setPublicationTimestamp(now);
                component.setUpdateTimestamp(now);
            }
            
            // Generate ID in the format @name@version
            component.setId(component.getName() + "@" + component.getVersion());
            
            // Save component
            return componentRepository.save(component);
        } finally {
            componentLock.unlock();
        }
    }

    /**
     * Retrieves a component by its name and version.
     *
     * @param name The component name
     * @param version The component version
     * @return The component
     * @throws ComponentNotFoundException if the component is not found
     */
    @Transactional(readOnly = true)
    public Component getComponent(String name, String version) {
        logger.info("Retrieving component: {} version {}", name, version);
        return componentRepository.findByNameAndVersion(name, version)
                .orElseThrow(() -> new ComponentNotFoundException(
                        "Component " + name + " with version " + version + " not found"));
    }

    /**
     * Retrieves all versions of a component by its name.
     *
     * @param name The component name
     * @return List of components with the specified name
     * @throws ComponentNotFoundException if no components with the given name are found
     */
    @Transactional(readOnly = true)
    public List<Component> getComponentVersions(String name) {
        logger.info("Retrieving all versions for component: {}", name);
        List<Component> components = componentRepository.findByNameOrderByVersionDesc(name);
        
        if (components.isEmpty()) {
            throw new ComponentNotFoundException("No components found with name: " + name);
        }
        
        return components;
    }

    /**
     * Retrieves all components in the repository.
     *
     * @return List of all components
     */
    @Transactional(readOnly = true)
    public List<Component> getAllComponents() {
        logger.info("Retrieving all components");
        return componentRepository.findAll();
    }

    /**
     * Updates an existing component.
     * Only the description and package content can be updated.
     *
     * @param name The component name
     * @param version The component version
     * @param updatedComponent The updated component data
     * @return The updated component
     * @throws ComponentNotFoundException if the component is not found
     */
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public Component updateComponent(String name, String version, Component updatedComponent) {
        logger.info("Updating component: {} version {}", name, version);
        
        try {
            // Acquire lock for this component to prevent concurrent modifications
            componentLock.lock();
            
            // Find existing component
            Component existingComponent = componentRepository.findByNameAndVersion(name, version)
                    .orElseThrow(() -> new ComponentNotFoundException(
                            "Component " + name + " with version " + version + " not found"));
            
            // Update package content if provided
            if (updatedComponent.getPackageContent() != null && updatedComponent.getPackageContent().length > 0) {
                existingComponent.setPackageContent(updatedComponent.getPackageContent());
            }
            
            // Update description if provided
            if (updatedComponent.getDescription() != null) {
                existingComponent.setDescription(updatedComponent.getDescription());
            }
            
            // Update timestamp
            existingComponent.setUpdateTimestamp(LocalDateTime.now());
            
            // Save updated component
            return componentRepository.save(existingComponent);
        } finally {
            componentLock.unlock();
        }
    }

    /**
     * Extracts metadata from a component package.
     * This is a placeholder for future implementation that would extract
     * metadata from the package content.
     *
     * @param component The component to extract metadata from
     * @return The component with extracted metadata
     */
    public Component extractMetadata(Component component) {
        // This is a placeholder for future implementation
        // In a real implementation, this would extract metadata from the package content
        logger.info("Extracting metadata for component: {} version {}", 
                component.getName(), component.getVersion());
        
        // For now, we just return the component as is
        return component;
    }
}