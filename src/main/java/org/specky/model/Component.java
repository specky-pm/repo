package org.specky.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Entity representing a component specification in the Specky Repository.
 * Components are stored with their metadata and binary package content.
 */
@Entity
@Table(name = "components")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Component {

    /**
     * Unique identifier for the component, following the format @name@version
     * Example: @specky/component-storage@1.2.3
     */
    @Id
    @Column(name = "id", nullable = false)
    private String id;

    /**
     * Component name, typically in the format @organization/name
     * Example: @specky/component-storage
     */
    @NotBlank
    @Column(name = "name", nullable = false)
    private String name;

    /**
     * Component version following semantic versioning (major.minor.patch)
     */
    @NotBlank
    @Pattern(regexp = "^\\d+\\.\\d+\\.\\d+$", message = "Version must follow semantic versioning format (e.g., 1.2.3)")
    @Column(name = "version", nullable = false)
    private String version;

    /**
     * Description of the component's purpose and functionality
     */
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    /**
     * Binary content of the component package (ZIP file)
     * Stored as a BYTEA in the PostgreSQL database
     */
    @Lob
    @Column(name = "package_content", nullable = false)
    @org.hibernate.annotations.JdbcTypeCode(java.sql.Types.BINARY)
    private byte[] packageContent;

    /**
     * Timestamp when the component was first published
     */
    @Column(name = "publication_timestamp", nullable = false)
    private LocalDateTime publicationTimestamp;

    /**
     * Timestamp when the component was last updated
     */
    @Column(name = "update_timestamp", nullable = false)
    private LocalDateTime updateTimestamp;
}