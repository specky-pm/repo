Feature: Component Version Listing
  As a user
  I want to list all available versions of a component
  So that I can choose the appropriate version for my needs

  Rule: All versions should be listed with relevant metadata

    Example: User lists all versions of a component
      Given a component exists in the repository
      And the component has multiple versions
      When the user requests to list all versions of the component
      Then the system should retrieve all versions
      And the versions should be sorted according to semantic versioning rules
      And each version should display relevant metadata
      And deprecated versions should be clearly indicated

    Example: User lists versions of a component with no deprecated versions
      Given a component exists in the repository
      And the component has multiple versions
      And none of the versions are deprecated
      When the user requests to list all versions of the component
      Then the system should retrieve all versions
      And the versions should be sorted according to semantic versioning rules
      And no versions should be marked as deprecated

    Example: User lists versions of a component with some deprecated versions
      Given a component exists in the repository
      And the component has multiple versions
      And some versions are deprecated
      When the user requests to list all versions of the component
      Then the system should retrieve all versions
      And the versions should be sorted according to semantic versioning rules
      And deprecated versions should be clearly indicated
      And each deprecated version should show its deprecation message