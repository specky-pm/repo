Feature: Component Publishing
  As a component developer
  I want to publish my component to the Specky repository
  So that others can discover and use it

  Rule: New components must have valid structure and metadata

    Example: User publishes a new component with valid structure
      Given a user has created a component with valid structure
      And the component has a valid spec.json file
      When the user uploads the component package
      Then the system should validate the component structure
      And the system should extract and validate the metadata
      And the system should store the component package
      And the system should index the component metadata for searching
      And the system should associate the component with the publishing user
      And subscribers should be notified about the new component

    Example: User attempts to publish a component with invalid structure
      Given a user has created a component with invalid structure
      When the user uploads the component package
      Then the system should reject the upload
      And the system should provide detailed validation errors
      And the component should not be stored

    Example: User attempts to publish a component with a duplicate name
      Given a user has created a component with a valid structure
      And a component with the same name already exists in the repository
      And the version is not different from the existing component
      When the user uploads the component package
      Then the system should reject the upload
      And the system should inform the user about the name conflict