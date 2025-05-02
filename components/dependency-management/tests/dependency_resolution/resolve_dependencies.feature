Feature: Dependency Resolution
  As a component user
  I want to resolve dependencies for a component
  So that I can use the component with all its required dependencies

  Rule: Semantic version ranges must be resolved to specific versions

    Example: System resolves semantic version ranges to specific versions
      Given a component "A" that depends on component "B" with version range "^1.2.0"
      And component "B" has versions "1.1.0", "1.2.0", "1.2.1", and "1.3.0" available
      When the system resolves dependencies for component "A"
      Then the system should select version "1.3.0" of component "B"
      And the resolution result should include the specific version selected

    Example: System handles complex version constraints
      Given a component "A" that depends on component "B" with version range ">=1.0.0 <2.0.0"
      And component "B" has versions "0.9.0", "1.0.0", "1.5.0", and "2.0.0" available
      When the system resolves dependencies for component "A"
      Then the system should select version "1.5.0" of component "B"
      And the resolution result should include the specific version selected

  Rule: Nested dependencies must be handled recursively

    Example: System resolves nested dependencies
      Given a component "A" that depends on component "B"
      And component "B" depends on component "C"
      And component "C" depends on component "D"
      When the system resolves dependencies for component "A"
      Then the resolution result should include components "B", "C", and "D"
      And each dependency should be resolved to a specific version

    Example: System detects circular dependencies
      Given a component "A" that depends on component "B"
      And component "B" depends on component "C"
      And component "C" depends on component "A"
      When the system resolves dependencies for component "A"
      Then the system should detect the circular dependency
      And the resolution result should include information about the circular dependency
      And the system should provide a visualization of the circular dependency path

  Rule: Version conflicts must be detected and resolved

    Example: System resolves version conflicts
      Given a component "A" that depends on component "C" version "^1.0.0"
      And component "A" also depends on component "B"
      And component "B" depends on component "C" version "^2.0.0"
      When the system resolves dependencies for component "A"
      Then the system should detect the version conflict for component "C"
      And the system should apply conflict resolution strategies
      And the resolution result should include information about the conflict resolution