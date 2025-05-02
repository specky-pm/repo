Feature: Dependency Compatibility Validation
  As a component developer
  I want to validate the compatibility of my component's dependencies
  So that I can ensure my component works correctly with its dependencies

  Rule: Version compatibility must be checked according to semver rules

    Example: System validates compatible dependency versions
      Given a component "A" that depends on component "B" with version range "^1.2.0"
      And component "B" has version "1.3.0" available
      When the system validates dependency compatibility
      Then the validation should succeed
      And the system should report that version "1.3.0" is compatible with the requirement

    Example: System identifies incompatible dependency versions
      Given a component "A" that depends on component "B" with version range "^1.2.0"
      And component "B" has only version "2.0.0" available
      When the system validates dependency compatibility
      Then the validation should fail
      And the system should report that version "2.0.0" is not compatible with the requirement

  Rule: Breaking changes between versions must be identified

    Example: System identifies breaking changes between major versions
      Given a component "B" with versions "1.0.0" and "2.0.0"
      And version "2.0.0" contains breaking changes
      When the system analyzes version compatibility
      Then the system should identify the breaking changes
      And the compatibility report should include details about the breaking changes

    Example: System identifies potential breaking changes in minor versions
      Given a component "B" with versions "1.0.0" and "1.1.0"
      And version "1.1.0" contains changes that might be breaking despite semver rules
      When the system analyzes version compatibility
      Then the system should flag the potential breaking changes
      And the compatibility report should include warnings about the potential issues

  Rule: Peer dependency requirements must be validated

    Example: System validates peer dependencies
      Given a component "A" that has a peer dependency on component "B" version "^2.0.0"
      And the user's environment has component "B" version "2.1.0" installed
      When the system validates peer dependencies
      Then the validation should succeed
      And the system should report that the peer dependency is satisfied

    Example: System warns about missing peer dependencies
      Given a component "A" that has a peer dependency on component "B" version "^2.0.0"
      And the user's environment does not have component "B" installed
      When the system validates peer dependencies
      Then the system should generate a warning
      And the warning should indicate that a required peer dependency is missing