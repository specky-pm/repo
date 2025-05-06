Feature: A user downloads a component

  Rule: The component package must be retrieved from storage
    
    Example: User downloads an existing component
      Given a component "auth-service" with version "1.0.0" exists in storage
      When the user requests to download component "auth-service" version "1.0.0"
      Then the component package is retrieved from storage
      And the component is prepared for download

  Rule: The component must be served as a zip file

    Example: User downloads a component as zip file
      Given a component "auth-service" with version "1.0.0" exists in storage
      When the user requests to download component "auth-service" version "1.0.0"
      Then the component package is prepared as a zip file
      And the zip file is served to the user

  Rule: If the requested component doesn't exist and error should occur

    Example: User attempts to download a non-existent component
      Given no component "non-existent-service" exists in storage
      When the user requests to download component "non-existent-service" version "1.0.0"
      Then an error occurs indicating the component does not exist