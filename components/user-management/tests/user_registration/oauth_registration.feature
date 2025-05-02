Feature: User Registration with OAuth Providers
  As a new user
  I want to register using an OAuth provider
  So that I can access the Specky repository system

  Rule: Users can register using OAuth providers

    Example: User registers with GitHub
      Given the user has a valid GitHub OAuth token
      When the user sends a registration request with the GitHub token
      Then the system should create a new user account
      And the system should extract basic profile information from GitHub
      And the system should return an authentication token

    Example: User registers with Google
      Given the user has a valid Google OAuth token
      When the user sends a registration request with the Google token
      Then the system should create a new user account
      And the system should extract basic profile information from Google
      And the system should return an authentication token

  Rule: Existing users are updated when registering with a new OAuth provider

    Example: Existing user registers with a new OAuth provider
      Given a user with an existing account
      And the user has a valid OAuth token from a new provider
      When the user sends a registration request with the new provider token
      Then the system should update the existing account with the new provider information
      And the system should return an authentication token