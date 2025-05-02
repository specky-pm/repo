Feature: Component Retrieval
  As a user
  I want to download specific component versions
  So that I can use them in my projects

  Rule: Users must have access to download components

    Example: User downloads a specific component version
      Given a user has access to a component
      And the component has multiple versions available
      When the user requests to download a specific version
      Then the system should retrieve the component package from storage
      And the system should track the download for statistics
      And the system should serve the component as a zip file
      And the download should complete successfully

    Example: User attempts to download a component without access
      Given a user does not have access to a restricted component
      When the user requests to download the component
      Then the system should deny the download request
      And the system should inform the user about the access restriction

    Example: User downloads a deprecated component version
      Given a user has access to a component
      And a specific version of the component is deprecated
      When the user requests to download the deprecated version
      Then the system should retrieve the component package
      And the system should provide a deprecation warning
      And the system should suggest alternative components if available
      And the download should complete with the warning

  Rule: Concurrent downloads must be handled efficiently

    Example: Multiple users download the same component simultaneously
      Given a popular component exists in the repository
      And multiple users request to download it simultaneously
      When the download requests are processed
      Then the system should handle all requests efficiently
      And all users should receive the complete component package
      And download statistics should be accurately tracked for each download