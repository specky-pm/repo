Feature: Component Deprecation
  As a component owner
  I want to deprecate my component
  So that users know it's no longer actively maintained

  Rule: Only authorized users can deprecate components

    Example: Component owner deprecates a component
      Given a user is the owner of a component
      When the user requests to deprecate the component
      And provides a deprecation message
      Then the system should mark the component as deprecated
      And store the deprecation message and timestamp
      And the component should still be available for download
      And downloads should include a deprecation warning

    Example: Component owner deprecates a specific version
      Given a user is the owner of a component
      And the component has multiple versions
      When the user requests to deprecate a specific version
      And provides a deprecation message
      Then the system should mark only that version as deprecated
      And store the deprecation message and timestamp for that version
      And that version should still be available for download
      And downloads of that version should include a deprecation warning

    Example: Non-owner attempts to deprecate a component
      Given a user is not the owner of a component
      And does not have administrative privileges
      When the user attempts to deprecate the component
      Then the system should deny the deprecation request
      And the component should remain unchanged

  Rule: Deprecated components can suggest alternatives

    Example: Component owner deprecates with alternative suggestions
      Given a user is the owner of a component
      When the user requests to deprecate the component
      And provides a deprecation message
      And specifies alternative components
      Then the system should mark the component as deprecated
      And store the deprecation message and timestamp
      And store the alternative component suggestions
      And downloads should include the deprecation warning
      And downloads should suggest the alternative components