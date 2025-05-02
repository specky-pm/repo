Feature: Component Unpublishing
  As a component owner
  I want to unpublish a component version
  So that it's no longer available for download

  Rule: Only authorized users can unpublish components

    Example: Component owner unpublishes a component version
      Given a user is the owner of a component
      And the component has multiple versions
      When the user requests to unpublish a specific version
      Then the system should verify the user has permission to unpublish
      And the system should remove the version from active listings
      And the system should maintain a record for audit purposes

    Example: Non-owner attempts to unpublish a component
      Given a user is not the owner of a component
      And does not have administrative privileges
      When the user attempts to unpublish a component version
      Then the system should deny the unpublish request
      And the component version should remain available

  Rule: Components with dependencies cannot be unpublished

    Example: User attempts to unpublish a component with dependencies
      Given a component version has other components depending on it
      When the owner attempts to unpublish the component version
      Then the system should reject the unpublish request
      And the system should inform the user about the existing dependencies
      And the component version should remain available

    Example: User unpublishes a component with no dependencies
      Given a component version has no other components depending on it
      When the owner requests to unpublish the component version
      Then the system should verify there are no dependencies
      And the system should remove the version from active listings
      And the system should maintain a record for audit purposes

  Rule: Unpublished components are removed from listings but records are maintained

    Example: User searches for an unpublished component
      Given a component version has been unpublished
      When a user searches for components
      Then the unpublished version should not appear in search results
      But administrators should be able to view the unpublished version in audit logs