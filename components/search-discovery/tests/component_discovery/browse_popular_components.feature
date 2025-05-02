Feature: Browse Popular Components
  As a user of the Specky repository
  I want to browse popular components
  So that I can discover widely-used components that might be useful for my projects

  Rule: Components must be ranked by download count

    Example: User views popular components
      Given the system contains multiple components with varying download counts
      When the user requests to view popular components
      Then the system should return components ordered by download count
      And components with higher download counts should appear first
      And each component should display its download count

    Example: User views popular components after download counts change
      Given the system contains multiple components with varying download counts
      And the download counts have recently changed
      When the user requests to view popular components
      Then the system should return components ordered by the updated download counts
      And the ranking should reflect the most current download data

  Rule: Rankings must be updated regularly

    Example: System updates popular component rankings
      Given the system tracks component download counts
      When new downloads occur for various components
      Then the system should update the popularity rankings
      And the updated rankings should be available to users
      And the last update timestamp should be visible

    Example: User views recently updated rankings
      Given the popular component rankings have been recently updated
      When the user requests to view popular components
      Then the system should display the most current rankings
      And the last update timestamp should be visible and recent

  Rule: Deprecated components must be excluded

    Example: User browses popular components with some deprecated
      Given the system contains both active and deprecated components
      And some deprecated components have high download counts
      When the user requests to view popular components
      Then the system should only include active components in the rankings
      And no deprecated components should be displayed

  Rule: Categorized popular components must be provided

    Example: User views popular components by category
      Given the system contains components in different categories
      When the user requests to view popular components in the "authentication" category
      Then the system should return popular components only from that category
      And components should be ordered by download count within the category

    Example: User switches between category views
      Given the user is viewing popular components in the "authentication" category
      When the user selects the "validation" category
      Then the system should display popular components from the "validation" category
      And components should be ordered by download count within the new category

  Rule: Time-based filtering (popular this week/month/year) must be allowed

    Example: User views components popular this week
      Given the system tracks download counts over time
      When the user requests to view components popular this week
      Then the system should return components based on downloads in the past 7 days
      And components with the most downloads in the past week should be ranked highest

    Example: User views components popular this month
      Given the system tracks download counts over time
      When the user requests to view components popular this month
      Then the system should return components based on downloads in the past 30 days
      And components with the most downloads in the past month should be ranked highest

    Example: User views components popular this year
      Given the system tracks download counts over time
      When the user requests to view components popular this year
      Then the system should return components based on downloads in the current year
      And components with the most downloads in the current year should be ranked highest

    Example: User switches between time periods
      Given the user is viewing components popular this week
      When the user selects to view components popular this month
      Then the system should update the rankings based on the monthly timeframe
      And the selected time period should be clearly indicated