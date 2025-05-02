Feature: Check User Permissions
  As a system component
  I want to check user permissions
  So that I can enforce proper access control

  Rule: The user must have the appropriate role for the requested action

    Example: User with publisher role accesses publishing functionality
      Given a user with the publisher role
      When the user attempts to access publishing functionality
      Then the system should verify the user has the publisher role
      And the system should grant access to the functionality

    Example: User without publisher role attempts to access publishing functionality
      Given a user without the publisher role
      When the user attempts to access publishing functionality
      Then the system should verify the user does not have the publisher role
      And the system should deny access to the functionality

    Example: Administrator accesses administrative functionality
      Given a user with the administrator role
      When the user attempts to access administrative functionality
      Then the system should verify the user has the administrator role
      And the system should grant access to the functionality

  Rule: Access must be denied if permissions are insufficient

    Example: User attempts to access functionality requiring higher permissions
      Given a user with basic permissions
      When the user attempts to access functionality requiring elevated permissions
      Then the system should deny access
      And the system should return a permissions error message

  Rule: Permission check failures must be logged

    Example: Failed permission check is logged
      Given a user without sufficient permissions
      When the user attempts to access restricted functionality
      Then the system should deny access
      And the system should log the permission check failure
      And the log should include the user ID, requested action, and timestamp