Feature: Component Version Updates
  As a component developer
  I want to update my existing component with a new version
  So that users can benefit from improvements and fixes

  Rule: Semantic versioning rules must be followed for updates

    Example: User publishes a new version of an existing component
      Given a user has an existing component in the repository
      And the user has created a new version of the component
      And the new version follows semantic versioning rules
      When the user uploads the new component version
      Then the system should validate the version number
      And the system should store the new version
      And the system should preserve all previous versions
      And the system should update the component metadata index
      And users should be notified of the component update

    Example: User attempts to publish a version with invalid semantic versioning
      Given a user has an existing component in the repository
      And the user has created a new version with an invalid version number
      When the user uploads the new component version
      Then the system should reject the upload
      And the system should provide semantic versioning validation errors

    Example: User attempts to publish a version that is not greater than existing versions
      Given a user has an existing component in the repository with version "1.2.0"
      And the user has created a new version with version "1.1.0"
      When the user uploads the new component version
      Then the system should reject the upload
      And the system should inform the user that the new version must be greater than existing versions