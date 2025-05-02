Feature: Validation Reporting
  As a component developer
  I want to receive detailed validation reports
  So that I can understand and fix issues in my component

  Background:
    Given the validation service is available
    And validation schemas are up-to-date

  Rule: Validation issues must be categorized by severity

    Example: Generating a report with issues of different severities
      Given I have a component package with the following validation issues:
        | File           | Issue                                  | Severity |
        | spec.json      | Missing description field              | error    |
        | component.md   | Inadequate overview section            | warning  |
        | datamodel.json | Attribute type could be more specific  | info     |
      When I request a validation report for the component package
      Then the validation report should categorize issues by severity
      And the validation report should show "1" error
      And the validation report should show "1" warning
      And the validation report should show "1" info

    Example: Generating a report with only warnings
      Given I have a component package with the following validation issues:
        | File           | Issue                                  | Severity |
        | component.md   | Inadequate overview section            | warning  |
        | component.md   | Missing examples in use cases          | warning  |
      When I request a validation report for the component package
      Then the validation report should categorize issues by severity
      And the validation report should show "0" errors
      And the validation report should show "2" warnings
      And the validation report should show "0" info
      And the validation should pass with warnings

  Rule: Error messages must include line numbers when applicable

    Example: Generating a report with line-specific issues
      Given I have a component package with the following validation issues:
        | File           | Issue                                  | Line | Column | Severity |
        | spec.json      | Invalid version format                 | 3    | 15     | error    |
        | component.md   | Broken markdown link                   | 42   | 10     | warning  |
      When I request a validation report for the component package
      Then the validation report should include line numbers for each issue
      And the validation report should include column numbers when available
      And the error message for "spec.json" should reference "line 3, column 15"
      And the warning message for "component.md" should reference "line 42, column 10"

    Example: Generating a report with file-level issues
      Given I have a component package with the following validation issues:
        | File           | Issue                                  | Severity |
        | spec.json      | Missing required fields                | error    |
        | tests/         | No test files present                  | warning  |
      When I request a validation report for the component package
      Then the validation report should indicate file-level issues without line numbers
      And the error message for "spec.json" should not reference a specific line

  Rule: Suggestions for resolving issues must be included

    Example: Generating a report with suggestions
      Given I have a component package with the following validation issues:
        | File           | Issue                                  | Severity | Suggestion                                           |
        | spec.json      | Missing description field              | error    | Add a 'description' field with component details     |
        | component.md   | Inadequate overview section            | warning  | Expand the overview to at least 3-4 sentences        |
      When I request a validation report for the component package
      Then the validation report should include suggestions for each issue
      And the suggestion for the "spec.json" error should be "Add a 'description' field with component details"
      And the suggestion for the "component.md" warning should be "Expand the overview to at least 3-4 sentences"

  Rule: Validation results must be formatted for both human and machine consumption

    Example: Requesting a human-readable validation report
      Given I have a component package with validation issues
      When I request a validation report in "HTML" format
      Then I should receive an HTML-formatted validation report
      And the report should be well-structured for human readability
      And the report should include visual indicators for different severity levels

    Example: Requesting a machine-readable validation report
      Given I have a component package with validation issues
      When I request a validation report in "JSON" format
      Then I should receive a JSON-formatted validation report
      And the report should contain structured data for programmatic processing
      And the report should include all validation details in a machine-parsable format

  Rule: Validation results must be filterable and sortable

    Example: Filtering validation results by severity
      Given I have a component package with various validation issues
      When I request a validation report filtered by severity "error"
      Then the validation report should only show error-level issues
      And warnings and info-level issues should be excluded

    Example: Sorting validation results by file
      Given I have a component package with validation issues in multiple files
      When I request a validation report sorted by "file"
      Then the validation report should group issues by file
      And within each file group, issues should be sorted by severity

    Example: Sorting validation results by severity
      Given I have a component package with validation issues of different severities
      When I request a validation report sorted by "severity"
      Then the validation report should group issues by severity level
      And within each severity group, issues should be sorted by file name