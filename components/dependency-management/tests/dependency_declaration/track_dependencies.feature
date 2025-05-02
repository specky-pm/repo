Feature: Dependency Tracking
  As a component developer
  I want to track components that depend on my component
  So that I can understand the impact of changes to my component

  Rule: Reverse dependency relationships must be maintained

    Example: System tracks components that depend on a specific component
      Given a component "A" exists in the repository
      And components "B" and "C" declare dependencies on component "A"
      When the system updates the dependency relationships
      Then component "A" should have "B" and "C" listed as dependents
      And the system should provide an API to query dependents of component "A"

    Example: System updates reverse dependencies when a new version is published
      Given a component "A" with version "1.0.0" exists in the repository
      And component "B" depends on component "A" version "^1.0.0"
      When a new version "1.1.0" of component "A" is published
      Then the system should update the dependency relationships
      And component "A" version "1.1.0" should have "B" listed as a potential dependent

  Rule: Dependency usage statistics must be tracked

    Example: System tracks dependency usage statistics
      Given multiple components depend on component "A"
      When the system generates dependency usage statistics
      Then the statistics should include the number of components depending on "A"
      And the statistics should include the most common version constraints
      And the statistics should include usage trends over time

    Example: System provides dependency usage report
      Given a component "A" exists in the repository
      And the system has tracked dependency relationships for component "A"
      When a user requests a dependency usage report for component "A"
      Then the report should include all components directly depending on "A"
      And the report should include version constraints used by each dependent
      And the report should include dependency types (regular, dev, peer, optional)