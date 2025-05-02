Feature: Explore Related Components
  As a user of the Specky repository
  I want to explore components related to ones I'm interested in
  So that I can discover additional components that might be useful for my projects

  Rule: Components with similar tags/keywords must be found

    Example: User views components with similar tags
      Given a component with tags "authentication, security, oauth"
      When the user requests to view related components
      Then the system should return components that share similar tags
      And components with more matching tags should be ranked higher
      And the matching tags should be highlighted for each component

    Example: User views components with partially matching tags
      Given a component with tags "validation, forms, input"
      When the user requests to view related components
      Then the system should return components that share at least one tag
      And the system should indicate which tags are shared for each component
      And components should be ranked by the number of matching tags

  Rule: Components from the same author must be found

    Example: User views other components by the same author
      Given a component created by author "Specky Team"
      When the user requests to view related components
      Then the system should return other components by the same author
      And the components should be clearly labeled as being from the same author
      And the components should be ordered by relevance or popularity

    Example: User views components from an author with many components
      Given a component created by an author with many published components
      When the user requests to view related components
      Then the system should return a selection of the author's most relevant components
      And the system should provide an option to view all components by the author

  Rule: Components that are commonly downloaded together must be found

    Example: User views components commonly downloaded together
      Given a component that users often download with other specific components
      When the user requests to view related components
      Then the system should return components commonly downloaded with the current one
      And the components should be ranked by how frequently they are downloaded together
      And the relationship should be clearly labeled as "Often downloaded together"

    Example: User views components with strong download correlation
      Given a component with strong download correlation to certain other components
      When the user requests to view related components
      Then the system should highlight components with the strongest download correlation
      And the system should indicate the strength of the relationship

  Rule: Components with similar dependencies must be found

    Example: User views components with similar dependencies
      Given a component with specific dependencies
      When the user requests to view related components
      Then the system should return components that share similar dependencies
      And components with more matching dependencies should be ranked higher
      And the matching dependencies should be indicated for each component

    Example: User views components that depend on the current component
      Given a component that other components depend on
      When the user requests to view related components
      Then the system should return components that depend on the current component
      And the dependency relationship should be clearly labeled

  Rule: Related components must be ranked by relevance

    Example: User views related components ranked by relevance
      Given a component with various types of relationships to other components
      When the user requests to view related components
      Then the system should return components ranked by overall relevance
      And the relevance score should consider all relationship types
      And the most relevant components should appear first

    Example: User filters related components by relationship type
      Given a component with various types of relationships to other components
      When the user requests to view related components
      And the user filters by a specific relationship type
      Then the system should only show components with that relationship type
      And components should be ranked by relevance within that relationship type