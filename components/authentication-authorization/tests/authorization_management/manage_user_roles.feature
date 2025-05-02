Feature: User Role Management
  As an administrator
  I want to manage user roles
  So that I can control access to system resources

  Rule: Role assignment requires administrator permissions

    Example: Administrator assigns roles to users
      Given an administrator with role management permissions
      When the administrator attempts to assign a role to a user
      Then the system should verify the administrator's permissions
      And the system should allow the role assignment

    Example: Non-administrator cannot assign roles
      Given a user without administrator permissions
      When the user attempts to assign a role to another user
      Then the system should verify the user's permissions
      And the system should deny the role assignment operation
      And the system should log the unauthorized attempt

  Rule: Role changes are validated against system constraints

    Example: System validates role assignment against constraints
      Given an administrator assigning a role to a user
      When the role assignment is submitted
      Then the system should check if the role assignment meets system constraints
      And the system should validate that the role exists
      And the system should ensure the role assignment doesn't violate any restrictions

    Example: System prevents conflicting role assignments
      Given an administrator attempting to assign conflicting roles
      When the role assignment is submitted
      Then the system should detect the role conflict
      And the system should reject the conflicting assignment
      And the system should provide information about the conflict

  Rule: User role information in the database is updated

    Example: System updates role information in database
      Given an administrator has assigned a new role to a user
      When the role assignment is confirmed
      Then the system should update the user's role information in the database
      And the system should maintain a history of role changes
      And the system should ensure data consistency

    Example: System handles role removal
      Given an administrator removing a role from a user
      When the role removal is confirmed
      Then the system should update the user's role information in the database
      And the system should revoke permissions associated with the removed role
      And the system should log the role removal for audit purposes

  Rule: Role changes are applied immediately to active sessions

    Example: Role changes affect active user sessions
      Given a user with an active session
      When an administrator changes the user's roles
      Then the system should apply the role changes to the active session
      And the system should update the user's permission context
      And subsequent permission checks should reflect the new roles

    Example: System handles role revocation for active sessions
      Given a user with an active session
      When an administrator revokes a critical role from the user
      Then the system should immediately restrict the user's permissions
      And the system should force re-authentication if required by security policy
      And the system should log the security-critical role change

  Rule: Affected users are notified of role changes

    Example: System notifies users of role assignments
      Given an administrator has assigned new roles to a user
      When the role assignment is completed
      Then the system should notify the affected user of their new roles
      And the notification should include information about new capabilities
      And the system should record that the notification was sent

    Example: System notifies users of role revocation
      Given an administrator has removed roles from a user
      When the role removal is completed
      Then the system should notify the affected user of the role changes
      And the notification should explain the impact on their permissions
      And the system should provide a contact for questions about the change