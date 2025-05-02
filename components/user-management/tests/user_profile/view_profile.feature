Feature: View User Profile
  As a registered user
  I want to view my profile information
  So that I can see my account details and activity history

  Rule: User details must be displayed when requested

    Example: User requests their profile information
      Given a registered user with an authenticated session
      When the user sends a request to view their profile
      Then the system should return the user's details
      And the response should include username and email

    Example: User requests profile with expanded information
      Given a registered user with an authenticated session
      When the user sends a request to view their profile with expanded details
      Then the system should return the user's complete profile
      And the response should include OAuth provider information
      And the response should include account status and registration date

  Rule: User's published components must be shown in profile

    Example: User with published components views profile
      Given a registered user with published components
      When the user sends a request to view their profile
      Then the system should return the user's details
      And the response should include a list of the user's published components
      And each component should include its name, version, and publication date

  Rule: User's download history must be shown in profile

    Example: User with download history views profile
      Given a registered user who has downloaded components
      When the user sends a request to view their profile
      Then the system should return the user's details
      And the response should include the user's download history
      And each download record should include the component name and download date