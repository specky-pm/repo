Feature: User Login
  As a registered user
  I want to log in to the system
  So that I can access my account and use the Specky repository

  Rule: Users can log in with valid OAuth credentials

    Example: User logs in with valid credentials
      Given a registered user
      And the user has valid OAuth credentials
      When the user sends a login request with their OAuth credentials
      Then the system should validate the credentials
      And the system should issue a JWT token
      And the system should record the login activity

    Example: User logs in with expired credentials
      Given a registered user
      And the user has expired OAuth credentials
      When the user sends a login request with their OAuth credentials
      Then the system should detect the expired credentials
      And the system should request a credential refresh
      And the system should issue a new JWT token after successful refresh

  Rule: JWT tokens are refreshed when needed

    Example: User refreshes an expiring token
      Given a registered user with an active session
      And the user's JWT token is about to expire
      When the user sends a token refresh request
      Then the system should validate the current token
      And the system should issue a new JWT token
      And the system should invalidate the old token