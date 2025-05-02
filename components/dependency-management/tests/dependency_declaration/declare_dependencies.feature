Feature: Dependency Declaration
  As a component developer
  I want to declare dependencies on other components
  So that my component can use functionality from other components

  Rule: Dependency declarations must be validated

    Example: Component declares valid dependencies
      Given a component with a valid spec.json file
      And the spec.json contains dependency declarations
      When the system validates the dependency declarations
      Then the validation should succeed
      And the dependencies should be stored in the database

    Example: Component declares non-existent dependency
      Given a component with a spec.json file
      And the spec.json contains a dependency on a non-existent component
      When the system validates the dependency declarations
      Then the validation should fail
      And an error message should indicate the missing dependency

  Rule: Semantic versioning ranges for dependencies must be supported

    Example: Component declares dependency with semantic version range
      Given a component with a spec.json file
      And the spec.json contains a dependency with version range "^1.2.0"
      When the system validates the dependency declarations
      Then the validation should succeed
      And the version range should be stored with the dependency

    Example: Component declares dependency with invalid version range
      Given a component with a spec.json file
      And the spec.json contains a dependency with invalid version range "not-a-version"
      When the system validates the dependency declarations
      Then the validation should fail
      And an error message should indicate the invalid version range

  Rule: Different dependency types must be differentiated

    Example: Component declares different types of dependencies
      Given a component with a spec.json file
      And the spec.json contains regular, dev, peer, and optional dependencies
      When the system validates the dependency declarations
      Then the validation should succeed
      And each dependency should be stored with its correct type
      And the system should handle each dependency type according to its rules