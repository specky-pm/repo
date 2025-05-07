package org.specky.repository;

import org.junit.jupiter.api.Test;
import org.specky.model.Component;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@ActiveProfiles("test")
class ComponentRepositoryTest {

    @Autowired
    private ComponentRepository componentRepository;

    @Test
    void testSaveAndRetrieveComponent() {
        // Create a test component
        Component component = new Component();
        component.setId("@specky-pm/test-component@1.0.0");
        component.setName("@specky-pm/test-component");
        component.setVersion("1.0.0");
        component.setDescription("Test component for repository testing");
        component.setPackageContent(new byte[]{1, 2, 3, 4, 5}); // Sample binary content
        LocalDateTime now = LocalDateTime.now();
        component.setPublicationTimestamp(now);
        component.setUpdateTimestamp(now);

        // Save the component
        Component savedComponent = componentRepository.save(component);

        // Verify the component was saved
        assertNotNull(savedComponent);
        assertEquals("@specky-pm/test-component@1.0.0", savedComponent.getId());

        // Retrieve the component by ID
        Optional<Component> retrievedComponentOpt = componentRepository.findById("@specky-pm/test-component@1.0.0");
        assertTrue(retrievedComponentOpt.isPresent());
        
        Component retrievedComponent = retrievedComponentOpt.get();
        assertEquals("@specky-pm/test-component", retrievedComponent.getName());
        assertEquals("1.0.0", retrievedComponent.getVersion());
        assertEquals("Test component for repository testing", retrievedComponent.getDescription());
        assertArrayEquals(new byte[]{1, 2, 3, 4, 5}, retrievedComponent.getPackageContent());
    }

    @Test
    void testFindByNameAndVersion() {
        // Create a test component
        Component component = new Component();
        component.setId("@specky-pm/test-component@1.0.0");
        component.setName("@specky-pm/test-component");
        component.setVersion("1.0.0");
        component.setDescription("Test component for repository testing");
        component.setPackageContent(new byte[]{1, 2, 3, 4, 5}); // Sample binary content
        LocalDateTime now = LocalDateTime.now();
        component.setPublicationTimestamp(now);
        component.setUpdateTimestamp(now);

        // Save the component
        componentRepository.save(component);

        // Find by name and version
        Optional<Component> foundComponent = componentRepository.findByNameAndVersion("@specky-pm/test-component", "1.0.0");
        assertTrue(foundComponent.isPresent());
        assertEquals("@specky-pm/test-component@1.0.0", foundComponent.get().getId());
    }

    @Test
    void testFindByNameOrderByVersionDesc() {
        // Create multiple versions of a component
        LocalDateTime now = LocalDateTime.now();
        byte[] sampleContent = new byte[]{1, 2, 3, 4, 5};
        
        Component component1 = new Component();
        component1.setId("@specky-pm/test-component@1.0.0");
        component1.setName("@specky-pm/test-component");
        component1.setVersion("1.0.0");
        component1.setDescription("Version 1.0.0");
        component1.setPackageContent(sampleContent);
        component1.setPublicationTimestamp(now.minusDays(2));
        component1.setUpdateTimestamp(now.minusDays(2));
        
        Component component2 = new Component();
        component2.setId("@specky-pm/test-component@1.1.0");
        component2.setName("@specky-pm/test-component");
        component2.setVersion("1.1.0");
        component2.setDescription("Version 1.1.0");
        component2.setPackageContent(sampleContent);
        component2.setPublicationTimestamp(now.minusDays(1));
        component2.setUpdateTimestamp(now.minusDays(1));
        
        Component component3 = new Component();
        component3.setId("@specky-pm/test-component@2.0.0");
        component3.setName("@specky-pm/test-component");
        component3.setVersion("2.0.0");
        component3.setDescription("Version 2.0.0");
        component3.setPackageContent(sampleContent);
        component3.setPublicationTimestamp(now);
        component3.setUpdateTimestamp(now);
        
        // Save all components
        componentRepository.save(component1);
        componentRepository.save(component2);
        componentRepository.save(component3);
        
        // Find all versions ordered by version descending
        List<Component> components = componentRepository.findByNameOrderByVersionDesc("@specky-pm/test-component");
        
        // Verify results
        assertEquals(3, components.size());
        assertEquals("2.0.0", components.get(0).getVersion());
        assertEquals("1.1.0", components.get(1).getVersion());
        assertEquals("1.0.0", components.get(2).getVersion());
    }

    @Test
    void testExistsForExistingComponent() {
        // Create a test component
        Component component = new Component();
        component.setId("@specky-pm/test-component@1.0.0");
        component.setName("@specky-pm/test-component");
        component.setVersion("1.0.0");
        component.setDescription("Test component for repository testing");
        component.setPackageContent(new byte[]{1, 2, 3, 4, 5}); // Sample binary content
        LocalDateTime now = LocalDateTime.now();
        component.setPublicationTimestamp(now);
        component.setUpdateTimestamp(now);

        // Save the component
        componentRepository.save(component);
        
        // Check if component exists
        assertTrue(componentRepository.existsByNameAndVersion("@specky-pm/test-component", "1.0.0"));
    }
    
    @Test
    void testNotExistsForDifferentVersion() {
        // Create a test component
        Component component = new Component();
        component.setId("@specky-pm/test-component@1.0.0");
        component.setName("@specky-pm/test-component");
        component.setVersion("1.0.0");
        component.setDescription("Test component for repository testing");
        component.setPackageContent(new byte[]{1, 2, 3, 4, 5}); // Sample binary content
        LocalDateTime now = LocalDateTime.now();
        component.setPublicationTimestamp(now);
        component.setUpdateTimestamp(now);

        // Save the component
        componentRepository.save(component);
        
        // Check if component with different version exists
        assertFalse(componentRepository.existsByNameAndVersion("@specky-pm/test-component", "2.0.0"));
    }
    
    @Test
    void testNotExistsForDifferentName() {
        // Create a test component
        Component component = new Component();
        component.setId("@specky-pm/test-component@1.0.0");
        component.setName("@specky-pm/test-component");
        component.setVersion("1.0.0");
        component.setDescription("Test component for repository testing");
        component.setPackageContent(new byte[]{1, 2, 3, 4, 5}); // Sample binary content
        LocalDateTime now = LocalDateTime.now();
        component.setPublicationTimestamp(now);
        component.setUpdateTimestamp(now);

        // Save the component
        componentRepository.save(component);
        
        // Check if component with different name exists
        assertFalse(componentRepository.existsByNameAndVersion("@specky-pm/non-existent", "1.0.0"));
    }
}