Feature: Update User Profile
  As a registered user
  I want to update my profile information
  So that my account details remain accurate

  Rule: Updated information must be validated

    Example: User updates profile with valid information
      Given a registered user with an authenticated session
      When the user sends a request to update their profile with valid information
      Then the system should validate the updated information
      And the system should accept the changes
      And the system should return the updated profile

    Example: User attempts to update profile with invalid information
      Given a registered user with an authenticated session
      When the user sends a request to update their profile with invalid information
      Then the system should validate the updated information
      And the system should reject the changes
      And the system should return validation error details

  Rule: The profile in the database must be updated

    Example: Database is updated after profile change
      Given a registered user with an authenticated session
      When the user successfully updates their profile information
      Then the system should persist the changes to the database
      And subsequent profile requests should return the updated information

  Rule: A history of profile changes must be maintained

    Example: Profile change history is recorded
      Given a registered user with an authenticated session
      When the user updates their profile multiple times
      Then the system should maintain a history of all profile changes
      And the system should record the timestamp of each change
      And the system should record the specific fields that were modified

    Example: User requests their profile change history
      Given a registered user with previous profile updates
      When the user sends a request to view their profile change history
      Then the system should return a chronological list of profile changes
      And each record should include the change date and modified fields