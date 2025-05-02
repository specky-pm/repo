Feature: OAuth Authentication Initiation
  As a user
  I want to authenticate using an OAuth provider
  So that I can access the Specky repository system securely

  Rule: Users can initiate authentication with an OAuth provider

    Example: User initiates authentication with a supported OAuth provider
      Given the system has multiple configured OAuth providers
      When the user requests to authenticate
      Then the system should present available OAuth provider options
      And the user should be able to select a provider

    Example: User selects an OAuth provider for authentication
      Given the user has been presented with OAuth provider options
      When the user selects a specific OAuth provider
      Then the system should redirect to that provider's authentication page
      And the system should include appropriate OAuth parameters in the request
      And the system should store a secure state parameter for validation

  Rule: System handles OAuth callback with authorization code

    Example: System processes successful OAuth callback
      Given a user has authenticated with an OAuth provider
      And the provider has redirected back with an authorization code
      When the system receives the OAuth callback
      Then the system should validate the state parameter
      And the system should exchange the authorization code for an access token
      And the system should retrieve the user's profile information from the provider

    Example: System handles OAuth callback with invalid state parameter
      Given a user has initiated OAuth authentication
      When the system receives an OAuth callback with an invalid state parameter
      Then the system should reject the authentication attempt
      And the system should log the security violation
      And the system should redirect the user to an error page

  Rule: System creates or updates user records based on OAuth information

    Example: System creates a new user record for first-time OAuth login
      Given a user has successfully authenticated with an OAuth provider
      And the user does not have an existing account in the system
      When the system processes the user's profile information
      Then the system should create a new user record
      And the system should associate the OAuth provider information with the user
      And the system should issue authentication tokens for the new user

    Example: System updates existing user record for returning OAuth user
      Given a user has successfully authenticated with an OAuth provider
      And the user already has an account in the system
      When the system processes the user's profile information
      Then the system should update the existing user record if needed
      And the system should issue new authentication tokens for the user