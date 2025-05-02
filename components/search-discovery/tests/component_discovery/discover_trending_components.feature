Feature: Discover Trending Components
  As a user of the Specky repository
  I want to discover trending components
  So that I can stay up-to-date with components gaining popularity in the community

  Rule: Components with rapidly increasing downloads must be identified

    Example: User views trending components based on download acceleration
      Given the system tracks component download rates over time
      When the user requests to view trending components
      Then the system should return components with rapidly increasing download rates
      And components should be ranked by their download growth rate
      And each component should display its growth metrics

    Example: System identifies new trending components
      Given the system continuously monitors component download patterns
      When a component shows a significant increase in download rate
      Then the system should add it to the trending components list
      And the component should be ranked according to its growth rate

  Rule: Recent activity (last 7/30 days) must be the focus

    Example: User views components trending in the last 7 days
      Given the system tracks component download rates over time
      When the user requests to view components trending in the last 7 days
      Then the system should return components based on download growth in the past week
      And components with the highest growth rate in the past week should be ranked first

    Example: User views components trending in the last 30 days
      Given the system tracks component download rates over time
      When the user requests to view components trending in the last 30 days
      Then the system should return components based on download growth in the past month
      And components with the highest growth rate in the past month should be ranked first

    Example: User switches between time periods
      Given the user is viewing components trending in the last 7 days
      When the user selects to view components trending in the last 30 days
      Then the system should update the rankings based on the monthly timeframe
      And the selected time period should be clearly indicated

  Rule: The trending list must be updated frequently

    Example: System updates trending components list
      Given the system tracks component download rates in real-time
      When download patterns change significantly
      Then the system should update the trending components list
      And the update should occur at least daily
      And the last update timestamp should be visible

    Example: User views recently updated trending list
      Given the trending components list has been recently updated
      When the user requests to view trending components
      Then the system should display the most current trending list
      And the last update timestamp should be visible and recent

  Rule: Context for why a component is trending must be provided

    Example: User views trending component with context
      Given a component is trending due to specific factors
      When the user views the trending components list
      Then the system should provide context for why each component is trending
      And the context should explain the factors contributing to its trend
      And the context should be concise and informative

    Example: User views detailed trend information
      Given a component is trending in the list
      When the user selects to view detailed trend information for that component
      Then the system should display comprehensive trend data
      And the data should include historical download patterns
      And the data should highlight when the trend began

  Rule: Filtering of trending components by category must be allowed

    Example: User filters trending components by category
      Given the system contains trending components in different categories
      When the user requests to view trending components in the "authentication" category
      Then the system should return trending components only from that category
      And components should be ordered by trend strength within the category

    Example: User views trending components across all categories
      Given the user has previously filtered trending components by category
      When the user selects to view trending components across all categories
      Then the system should display trending components from all categories
      And components should be ordered by overall trend strength