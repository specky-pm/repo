package org.specky.repository;

import org.specky.model.Component;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository interface for Component entity operations.
 * Provides methods for CRUD operations and custom queries.
 */
@Repository
public interface ComponentRepository extends JpaRepository<Component, String> {

    /**
     * Find a component by its name and version.
     *
     * @param name    The component name
     * @param version The component version
     * @return Optional containing the component if found
     */
    Optional<Component> findByNameAndVersion(String name, String version);

    /**
     * Find all components with a specific name, returning all available versions.
     *
     * @param name The component name
     * @return List of components with the specified name
     */
    List<Component> findByNameOrderByVersionDesc(String name);

    /**
     * Check if a component with the given name and version exists.
     *
     * @param name    The component name
     * @param version The component version
     * @return true if the component exists, false otherwise
     */
    boolean existsByNameAndVersion(String name, String version);
}