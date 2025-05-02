Feature: Filter Search Results
  As a user of the Specky repository
  I want to apply filters to my search results
  So that I can narrow down the results to find the most relevant components

  Rule: Filtering by author/publisher must be supported

    Example: User filters search results by a specific author
      Given the user has performed a search with multiple results
      When the user applies a filter for author "Specky Team"
      Then the system should only display components by that author
      And the filter should be applied without requiring a new search
      And the filter should be visible to the user

    Example: User removes an author filter
      Given the user has performed a search with multiple results
      And the user has applied a filter for author "Specky Team"
      When the user removes the author filter
      Then the system should display all components from the original search
      And the filter should no longer be visible to the user

  Rule: Filtering by tags/keywords must be supported

    Example: User filters search results by a specific tag
      Given the user has performed a search with multiple results
      When the user applies a filter for the tag "authentication"
      Then the system should only display components with that tag
      And the filter should be applied without requiring a new search
      And the filter should be visible to the user

    Example: User applies multiple tag filters
      Given the user has performed a search with multiple results
      When the user applies a filter for the tag "authentication"
      And the user applies a filter for the tag "oauth"
      Then the system should only display components with both tags
      And both filters should be visible to the user

  Rule: Filtering by date range must be supported

    Example: User filters search results by publish date
      Given the user has performed a search with multiple results
      When the user applies a date range filter for the last 30 days
      Then the system should only display components published within that period
      And the filter should be applied without requiring a new search
      And the filter should be visible to the user

    Example: User filters search results by a custom date range
      Given the user has performed a search with multiple results
      When the user applies a custom date range filter from "2024-01-01" to "2024-03-31"
      Then the system should only display components published within that period
      And the filter should be applied without requiring a new search
      And the filter should be visible to the user

  Rule: Filtering by download count must be supported

    Example: User filters search results by minimum download count
      Given the user has performed a search with multiple results
      When the user applies a filter for components with at least 100 downloads
      Then the system should only display components with 100 or more downloads
      And the filter should be applied without requiring a new search
      And the filter should be visible to the user

    Example: User filters search results by download count range
      Given the user has performed a search with multiple results
      When the user applies a filter for components with between 50 and 500 downloads
      Then the system should only display components within that download range
      And the filter should be applied without requiring a new search
      And the filter should be visible to the user

  Rule: Filters must be applied incrementally without requiring a new search

    Example: User applies multiple filters incrementally
      Given the user has performed a search with multiple results
      When the user applies a filter for author "Specky Team"
      And the user applies a filter for the tag "authentication"
      And the user applies a date range filter for the last 30 days
      Then each filter should be applied immediately after selection
      And the result set should become progressively smaller
      And all applied filters should be visible to the user