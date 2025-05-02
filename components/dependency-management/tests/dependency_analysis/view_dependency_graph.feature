Feature: Dependency Graph Visualization
  As a component developer
  I want to view the dependency graph for a component
  So that I can understand the relationships between components

  Rule: A visual representation of dependencies must be generated

    Example: System generates a dependency graph
      Given a component "A" with dependencies
      When a user requests the dependency graph for component "A"
      Then the system should generate a visual representation of the dependencies
      And the graph should show component "A" as the root node
      And the graph should show direct dependencies as connected nodes

    Example: System provides different visualization formats
      Given a component "A" with dependencies
      When a user requests the dependency graph in a specific format
      Then the system should generate the graph in the requested format
      And the system should support multiple visualization formats

  Rule: Direct and transitive dependencies must be shown

    Example: System shows both direct and transitive dependencies
      Given a component "A" that depends on component "B"
      And component "B" depends on components "C" and "D"
      When a user requests the dependency graph for component "A"
      Then the graph should show "B" as a direct dependency
      And the graph should show "C" and "D" as transitive dependencies
      And the graph should indicate the dependency path for transitive dependencies

    Example: System allows filtering dependency graph depth
      Given a component "A" with a deep dependency tree
      When a user requests the dependency graph with a specified depth limit
      Then the graph should only show dependencies up to the specified depth
      And the system should indicate that some dependencies are not shown due to the depth limit

  Rule: Circular dependencies must be highlighted

    Example: System highlights circular dependencies in the graph
      Given a component "A" that depends on component "B"
      And component "B" depends on component "C"
      And component "C" depends on component "A"
      When a user requests the dependency graph for component "A"
      Then the graph should highlight the circular dependency path
      And the system should provide details about the circular dependency

    Example: System provides circular dependency analysis
      Given a component with circular dependencies
      When a user requests a circular dependency analysis
      Then the system should identify all circular dependency paths
      And the system should suggest possible ways to resolve the circular dependencies

  Rule: Interactive exploration of the dependency graph must be allowed

    Example: User interactively explores the dependency graph
      Given a component with a complex dependency graph
      When a user interacts with the dependency graph
      Then the system should allow expanding and collapsing nodes
      And the system should allow focusing on specific dependencies
      And the system should provide detailed information about selected dependencies