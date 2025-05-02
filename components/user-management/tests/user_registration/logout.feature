Feature: User Logout
  As a logged-in user
  I want to log out of the system
  So that my session is securely terminated

  Rule: Current session tokens must be invalidated on logout

    Example: User logs out of the system
      Given a user with an active session
      When the user sends a logout request
      Then the system should invalidate the user's current JWT token
      And the system should return a successful logout confirmation

    Example: User attempts to use an invalidated token
      Given a user who has logged out
      When the user attempts to access a protected resource with the invalidated token
      Then the system should reject the request
      And the system should return an authentication error

  Rule: All session-related data must be cleared on logout

    Example: Session data is cleared after logout
      Given a user with an active session and associated session data
      When the user sends a logout request
      Then the system should clear all session-related data
      And the system should invalidate any persistent session cookies