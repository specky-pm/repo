Feature: Permission Checking
  As a system component
  I want to check if a user can perform an action
  So that I can enforce proper access control

  Rule: System retrieves user's roles and permissions

    Example: System retrieves roles for permission check
      Given a user with specific assigned roles
      When the system needs to check the user's permissions
      Then the system should retrieve all roles assigned to the user
      And the system should retrieve all permissions associated with those roles

    Example: System handles users with multiple roles
      Given a user with multiple assigned roles
      When the system checks the user's permissions
      Then the system should aggregate permissions from all roles
      And the system should resolve any permission conflicts according to policy

  Rule: System evaluates permission requirements for actions

    Example: System checks specific permission for an action
      Given a protected action that requires specific permissions
      When a user attempts to perform the action
      Then the system should identify the required permissions for the action
      And the system should check if the user has the required permissions
      And the system should allow the action if the user has the permissions

    Example: System handles actions requiring multiple permissions
      Given a protected action that requires multiple permissions
      When a user attempts to perform the action
      Then the system should check if the user has all required permissions
      And the system should deny the action if any permission is missing

  Rule: System applies role-based access control

    Example: System allows action based on user role
      Given a user with a role that grants permission for an action
      When the user attempts to perform the action
      Then the system should verify the user's role
      And the system should allow the action based on role-based permissions

    Example: System denies action based on missing role
      Given a user without a role that grants permission for an action
      When the user attempts to perform the action
      Then the system should verify the user's roles
      And the system should deny the action due to insufficient role-based permissions

  Rule: System considers resource ownership in permission checks

    Example: System allows action for resource owner
      Given a user who owns a specific resource
      When the user attempts to perform an action on that resource
      Then the system should verify the user's ownership of the resource
      And the system should allow the action based on ownership

    Example: System applies different permissions for owned vs. non-owned resources
      Given a user with limited permissions
      When the user attempts to perform an action on a resource they don't own
      Then the system should apply stricter permission requirements
      And the system should deny the action if the user lacks sufficient permissions

  Rule: System logs authorization decisions for audit purposes

    Example: System logs successful authorization
      Given a user attempts to perform an authorized action
      When the system grants permission
      Then the system should log the authorization decision
      And the log should include the user, action, resource, and decision

    Example: System logs denied authorization
      Given a user attempts to perform an unauthorized action
      When the system denies permission
      Then the system should log the authorization decision with reason
      And the system should include sufficient context for audit purposes