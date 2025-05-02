Feature: User Logout
  As a user
  I want to log out from the system
  So that my session is terminated and my account is secured

  Rule: System invalidates authentication tokens on logout

    Example: User logs out and tokens are invalidated
      Given a user is authenticated with valid tokens
      When the user requests to log out
      Then the system should invalidate all active tokens for the user
      And the system should add the tokens to a blacklist
      And the system should confirm successful logout

    Example: System rejects requests with invalidated tokens
      Given a user has logged out
      And their authentication tokens have been invalidated
      When a request is made using an invalidated token
      Then the system should reject the request
      And the system should return an authentication error

  Rule: System removes session information

    Example: System clears session data on logout
      Given a user is authenticated with an active session
      When the user logs out
      Then the system should clear all session data
      And the system should remove any persistent session cookies
      And the system should terminate server-side session storage

  Rule: System handles post-logout redirection

    Example: User is redirected after logout
      Given a user is authenticated
      When the user logs out
      Then the system should redirect the user to the appropriate post-logout page
      And the system should not include any authentication information in the redirect

    Example: System handles logout with redirect parameter
      Given a user is authenticated
      When the user logs out with a specific redirect URL parameter
      Then the system should validate the redirect URL
      And the system should redirect to the specified URL if it is allowed
      And the system should redirect to the default logout page if the URL is not allowed

  Rule: System handles single sign-out when applicable

    Example: System performs single sign-out across integrated services
      Given a user is authenticated across multiple integrated services
      When the user initiates logout from one service
      Then the system should propagate the logout to all connected services
      And the system should invalidate sessions across all services
      And the system should confirm complete logout from all services

    Example: System handles single sign-out failure gracefully
      Given a user is authenticated across multiple integrated services
      When the user initiates logout and some services are unavailable
      Then the system should complete logout from available services
      And the system should log the failed logout attempts
      And the system should inform the user of partial logout completion