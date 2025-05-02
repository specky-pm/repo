Feature: Resource Ownership Management
  As a system
  I want to manage resource ownership
  So that access control can be properly enforced based on ownership

  Rule: Ownership is assigned when resources are created

    Example: System assigns ownership on resource creation
      Given a user creates a new resource
      When the resource creation is completed
      Then the system should automatically assign ownership to the creating user
      And the system should record the ownership assignment
      And the ownership information should be stored with the resource metadata

    Example: System handles resource creation by service accounts
      Given a service account creates a new resource
      When the resource creation is completed
      Then the system should assign appropriate ownership based on service context
      And the system should apply default access controls for service-created resources

  Rule: Ownership is verified for protected operations

    Example: System allows operations for resource owner
      Given a user owns a specific resource
      When the user attempts to perform a protected operation on the resource
      Then the system should verify the user's ownership
      And the system should allow the operation based on ownership

    Example: System restricts operations for non-owners
      Given a user does not own a specific resource
      When the user attempts to perform an owner-restricted operation
      Then the system should verify the user is not the owner
      And the system should deny the operation
      And the system should log the unauthorized access attempt

  Rule: Ownership transfer between users is supported

    Example: Owner transfers resource ownership
      Given a user owns a resource
      When the user initiates an ownership transfer to another user
      Then the system should validate the transfer request
      And the system should update the ownership records
      And the system should notify both users of the ownership change

    Example: Administrator transfers resource ownership
      Given an administrator with ownership management permissions
      When the administrator transfers ownership of a resource between users
      Then the system should validate the administrator's permissions
      And the system should update the ownership records
      And the system should notify affected users of the ownership change

  Rule: Orphaned resources are handled when users are removed

    Example: System handles resources when user is deleted
      Given a user owns multiple resources
      When the user's account is deleted from the system
      Then the system should identify all resources owned by the deleted user
      And the system should apply the configured orphaned resource policy
      And the system should reassign or archive the resources as appropriate

    Example: System transfers ownership during account deactivation
      Given a user with resources is being deactivated
      When the deactivation process is initiated
      Then the system should prompt for ownership transfer decisions
      And the system should execute the specified ownership transfers
      And the system should log all ownership changes for audit purposes

  Rule: Team/group ownership models are supported

    Example: Resource is owned by a team
      Given a resource that can be owned by a team
      When a team is assigned as the owner
      Then the system should record the team ownership
      And the system should grant appropriate access to all team members
      And the system should handle team membership changes

    Example: System manages hierarchical ownership
      Given a resource with hierarchical ownership structure
      When ownership permissions are evaluated
      Then the system should consider the entire ownership hierarchy
      And the system should apply inheritance rules for permissions
      And the system should resolve conflicts according to defined policies