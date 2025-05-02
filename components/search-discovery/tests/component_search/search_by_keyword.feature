Feature: Component Search by Keyword
  As a user of the Specky repository
  I want to search for components using keywords
  So that I can find components that meet my specific needs

  Rule: Component names, descriptions, and keywords must be searched

    Example: User searches with a keyword that matches component names
      Given the system contains multiple components
      When the user performs a search with the keyword "authentication"
      Then the system should return components with "authentication" in their names
      And the results should be ranked by relevance
      And basic metadata should be included for each result

    Example: User searches with a keyword that matches component descriptions
      Given the system contains multiple components
      When the user performs a search with the keyword "security"
      Then the system should return components with "security" in their descriptions
      And the results should be ranked by relevance
      And basic metadata should be included for each result

    Example: User searches with a keyword that matches component tags
      Given the system contains multiple components
      When the user performs a search with the keyword "oauth"
      Then the system should return components with "oauth" in their tags
      And the results should be ranked by relevance
      And basic metadata should be included for each result

  Rule: Deprecated components must be filtered out unless explicitly included

    Example: User searches without specifying to include deprecated components
      Given the system contains both active and deprecated components
      When the user performs a search with the keyword "validation"
      Then the system should only return active components
      And no deprecated components should be included in the results

    Example: User searches and explicitly includes deprecated components
      Given the system contains both active and deprecated components
      When the user performs a search with the keyword "validation"
      And the user specifies to include deprecated components
      Then the system should return both active and deprecated components
      And deprecated components should be clearly marked in the results

  Rule: Results must be paginated

    Example: User views the first page of search results
      Given the system contains many components matching a search term
      When the user performs a search with the keyword "component"
      Then the system should return the first page of results
      And the response should include pagination metadata
      And the response should indicate the total number of results

    Example: User navigates to the next page of search results
      Given the user has performed a search with many results
      And the user is viewing the first page of results
      When the user requests the next page of results
      Then the system should return the second page of results
      And the results should maintain the same sorting order