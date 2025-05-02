Feature: Sort Search Results
  As a user of the Specky repository
  I want to sort my search results in different ways
  So that I can find the most relevant components based on my criteria

  Rule: Sorting by relevance (default) must be supported

    Example: User performs a search with default sorting
      Given the system contains multiple components
      When the user performs a search with the keyword "authentication"
      Then the system should return results sorted by relevance
      And components with higher relevance to the search term should appear first
      And the current sort method should be indicated as "relevance"

    Example: User explicitly selects relevance sorting
      Given the user has performed a search with results sorted by another method
      When the user selects to sort by relevance
      Then the system should re-order the results by relevance
      And components with higher relevance to the search term should appear first
      And the current sort method should be indicated as "relevance"

  Rule: Sorting by publish date (newest/oldest) must be supported

    Example: User sorts search results by newest first
      Given the user has performed a search with multiple results
      When the user selects to sort by publish date (newest first)
      Then the system should re-order the results by publish date
      And the most recently published components should appear first
      And the current sort method should be indicated as "newest first"

    Example: User sorts search results by oldest first
      Given the user has performed a search with multiple results
      When the user selects to sort by publish date (oldest first)
      Then the system should re-order the results by publish date
      And the oldest published components should appear first
      And the current sort method should be indicated as "oldest first"

  Rule: Sorting by download count (most/least) must be supported

    Example: User sorts search results by most downloaded
      Given the user has performed a search with multiple results
      When the user selects to sort by download count (most first)
      Then the system should re-order the results by download count
      And components with the highest download count should appear first
      And the current sort method should be indicated as "most downloaded"

    Example: User sorts search results by least downloaded
      Given the user has performed a search with multiple results
      When the user selects to sort by download count (least first)
      Then the system should re-order the results by download count
      And components with the lowest download count should appear first
      And the current sort method should be indicated as "least downloaded"

  Rule: Sorting by name (alphabetical) must be supported

    Example: User sorts search results alphabetically (A-Z)
      Given the user has performed a search with multiple results
      When the user selects to sort alphabetically (A-Z)
      Then the system should re-order the results alphabetically by name
      And components should be listed in ascending alphabetical order
      And the current sort method should be indicated as "A-Z"

    Example: User sorts search results alphabetically (Z-A)
      Given the user has performed a search with multiple results
      When the user selects to sort alphabetically (Z-A)
      Then the system should re-order the results alphabetically by name
      And components should be listed in descending alphabetical order
      And the current sort method should be indicated as "Z-A"

  Rule: Sort order must be maintained during pagination

    Example: User navigates through pages with a specific sort order
      Given the user has performed a search with many results
      And the user has sorted the results by download count (most first)
      When the user navigates to the second page of results
      Then the system should maintain the same sort order on the second page
      And the components should continue to be ordered by download count (most first)
      And the current sort method should still be indicated as "most downloaded"

    Example: User changes sort order and then navigates through pages
      Given the user has performed a search with many results
      And the user is viewing the first page of results
      When the user changes the sort order to alphabetical (A-Z)
      And the user navigates to the second page of results
      Then the system should maintain the alphabetical sort order on the second page
      And the current sort method should still be indicated as "A-Z"