Feature: Assign User Roles
  As an administrator
  I want to assign roles to users
  So that they have appropriate permissions in the system

  Rule: The system must support different role types

    Example: Administrator assigns publisher role to a user
      Given an administrator with an authenticated session
      And a regular user in the system
      When the administrator sends a request to assign the publisher role to the user
      Then the system should update the user's roles to include publisher
      And the system should return the updated user role information

    Example: Administrator assigns multiple roles to a user
      Given an administrator with an authenticated session
      And a regular user in the system
      When the administrator sends a request to assign multiple roles to the user
      Then the system should update the user's roles to include all assigned roles
      And the system should return the updated user role information

  Rule: Role assignment permissions must be validated

    Example: Non-administrator attempts to assign roles
      Given a regular user with an authenticated session
      When the user attempts to assign a role to another user
      Then the system should reject the request
      And the system should return a permissions error

    Example: Administrator attempts to assign invalid role
      Given an administrator with an authenticated session
      When the administrator attempts to assign an invalid role to a user
      Then the system should reject the request
      And the system should return a validation error

  Rule: Users must be notified of role changes

    Example: User is notified of role assignment
      Given a regular user in the system
      When an administrator assigns a new role to the user
      Then the system should update the user's roles
      And the system should send a notification to the user about the role change
      And the notification should include details about the new permissions