Feature: Component Package Validation
  As a component publisher
  I want to validate my component package
  So that I can ensure it meets all requirements before publishing

  Background:
    Given the validation service is available
    And validation schemas are up-to-date

  Rule: Component packages must contain all required files

    Example: Validating a complete component package
      Given I have a component package with the following files:
        | File           | Status   |
        | spec.json      | present  |
        | component.md   | present  |
        | datamodel.json | present  |
        | tests/         | present  |
      When I request validation of the component package
      Then the validation should pass
      And the validation report should indicate "0" errors
      And the validation report should indicate "0" warnings

    Example: Validating a component package with missing required files
      Given I have a component package with the following files:
        | File           | Status   |
        | spec.json      | present  |
        | component.md   | missing  |
        | datamodel.json | present  |
        | tests/         | present  |
      When I request validation of the component package
      Then the validation should fail
      And the validation report should indicate "1" errors
      And the validation report should include the error "Missing required file: component.md"

  Rule: Optional files must be checked when present

    Example: Validating a component package with optional files
      Given I have a component package with the following files:
        | File                    | Status   |
        | spec.json               | present  |
        | component.md            | present  |
        | datamodel.json          | present  |
        | tests/feature1.feature  | present  |
        | tests/feature2.feature  | present  |
      When I request validation of the component package
      Then the validation should pass
      And the validation report should indicate all files were validated

    Example: Validating a component package with invalid optional files
      Given I have a component package with the following files:
        | File                    | Status   |
        | spec.json               | present  |
        | component.md            | present  |
        | datamodel.json          | present  |
        | tests/invalid.feature   | present  |
      And the file "tests/invalid.feature" contains invalid Gherkin syntax
      When I request validation of the component package
      Then the validation should pass with warnings
      And the validation report should indicate "0" errors
      And the validation report should indicate "1" warnings
      And the validation report should include the warning "Invalid Gherkin syntax in tests/invalid.feature"

  Rule: No extraneous or potentially harmful files must be included

    Example: Validating a component package with extraneous files
      Given I have a component package with the following files:
        | File                    | Status   |
        | spec.json               | present  |
        | component.md            | present  |
        | datamodel.json          | present  |
        | tests/feature1.feature  | present  |
        | .DS_Store               | present  |
        | node_modules/           | present  |
      When I request validation of the component package
      Then the validation should pass with warnings
      And the validation report should indicate "0" errors
      And the validation report should indicate "2" warnings
      And the validation report should include the warning "Extraneous file detected: .DS_Store"
      And the validation report should include the warning "Extraneous directory detected: node_modules/"

    Example: Validating a component package with potentially harmful files
      Given I have a component package with the following files:
        | File                    | Status   |
        | spec.json               | present  |
        | component.md            | present  |
        | datamodel.json          | present  |
        | tests/feature1.feature  | present  |
        | script.exe              | present  |
      When I request validation of the component package
      Then the validation should fail
      And the validation report should indicate "1" errors
      And the validation report should include the error "Potentially harmful file detected: script.exe"

  Rule: Package size must be within acceptable limits

    Example: Validating a component package with acceptable size
      Given I have a component package with a total size of "500KB"
      When I request validation of the component package
      Then the validation should pass
      And the validation report should not mention size issues

    Example: Validating a component package exceeding size limits
      Given I have a component package with a total size of "50MB"
      When I request validation of the component package
      Then the validation should fail
      And the validation report should indicate "1" errors
      And the validation report should include the error "Package size exceeds the maximum allowed limit of 10MB"