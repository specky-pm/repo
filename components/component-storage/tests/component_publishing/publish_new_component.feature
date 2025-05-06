Feature: A user publishes a component

  Rule: The component package must be stored in the system

    Example: System successfully stores a new component package
      Given a user has a valid component package
      When the user uploads the component package
      Then the system should store the component package in the storage
      And the system should confirm successful storage
      And the component should be available for retrieval

    Example: System fails to store an invalid component package
      Given a user has an invalid component package
      When the user uploads the component package
      Then the system should reject the component package
      And the system should report storage failure
      And the component should not be available for retrieval


  Rule: Component metadata should be stored in the system

    Example: User publishes a new component with valid structure
      Given a user has created a component with valid and spec.json file
      When the user uploads the component package
      Then the metadata from the spec.json should be found in the system

  Rule: an existing component will be overwritten given the same name and version

    Example: User attempts to publish a component with a duplicate name and version
      Given a user has created a component with a valid structure
      And a component with the same name and version already exists in the repository
      When the user uploads the component package
      Then the system should overwrite the existing component
      And the metadata from the new spec.json should be found in the system
