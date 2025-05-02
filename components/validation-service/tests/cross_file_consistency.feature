Feature: Cross-File Consistency Checking
  As a component developer
  I want to ensure consistency across all files in my component package
  So that there are no contradictions or misalignments between files

  Background:
    Given the validation service is available
    And validation schemas are up-to-date

  Rule: Component name must be consistent across all files

    Example: Validating consistent component names
      Given I have a component package with the following files:
        | File           | Component Name      |
        | spec.json      | "Validation Service" |
        | component.md   | "Validation Service" |
      When I request cross-file consistency validation
      Then the validation should pass
      And the validation report should indicate "0" consistency errors

    Example: Validating inconsistent component names
      Given I have a component package with the following files:
        | File           | Component Name      |
        | spec.json      | "Validation Service" |
        | component.md   | "Validator Service"  |
      When I request cross-file consistency validation
      Then the validation should fail
      And the validation report should indicate "1" consistency errors
      And the validation report should include the error "Inconsistent component name between spec.json and component.md"

  Rule: Dependencies declared in spec.json must be referenced in component.md

    Example: Validating consistent dependency references
      Given I have a "spec.json" file that declares dependencies on:
        | Component Name        |
        | Component Storage     |
        | User Management       |
      And I have a "component.md" file that references:
        | Component Name        |
        | Component Storage     |
        | User Management       |
      When I request cross-file consistency validation
      Then the validation should pass
      And the validation report should indicate "0" consistency errors

    Example: Validating missing dependency references
      Given I have a "spec.json" file that declares dependencies on:
        | Component Name        |
        | Component Storage     |
        | User Management       |
      And I have a "component.md" file that references:
        | Component Name        |
        | Component Storage     |
      When I request cross-file consistency validation
      Then the validation should pass with warnings
      And the validation report should indicate "1" consistency warnings
      And the validation report should include the warning "Dependency 'User Management' declared in spec.json is not referenced in component.md"

  Rule: Entities in datamodel.json must be consistent with component.md descriptions

    Example: Validating consistent entity references
      Given I have a "datamodel.json" file that defines entities:
        | Entity Name           |
        | ValidationSchema      |
        | ValidationRule        |
        | ValidationResult      |
      And I have a "component.md" file that references entities:
        | Entity Name           |
        | ValidationSchema      |
        | ValidationRule        |
        | ValidationResult      |
      When I request cross-file consistency validation
      Then the validation should pass
      And the validation report should indicate "0" consistency errors

    Example: Validating missing entity references
      Given I have a "datamodel.json" file that defines entities:
        | Entity Name           |
        | ValidationSchema      |
        | ValidationRule        |
        | ValidationResult      |
      And I have a "component.md" file that references entities:
        | Entity Name           |
        | ValidationSchema      |
        | ValidationRule        |
      When I request cross-file consistency validation
      Then the validation should pass with warnings
      And the validation report should indicate "1" consistency warnings
      And the validation report should include the warning "Entity 'ValidationResult' defined in datamodel.json is not referenced in component.md"

  Rule: Feature files must be consistent with features described in component.md

    Example: Validating consistent feature references
      Given I have a "component.md" file that describes features:
        | Feature Name                  |
        | Component Package Validation  |
        | File-Specific Validation      |
        | Validation Reporting          |
      And I have feature files for:
        | Feature Name                  |
        | Component Package Validation  |
        | File-Specific Validation      |
        | Validation Reporting          |
      When I request cross-file consistency validation
      Then the validation should pass
      And the validation report should indicate "0" consistency errors

    Example: Validating missing feature files
      Given I have a "component.md" file that describes features:
        | Feature Name                  |
        | Component Package Validation  |
        | File-Specific Validation      |
        | Validation Reporting          |
      And I have feature files for:
        | Feature Name                  |
        | Component Package Validation  |
        | File-Specific Validation      |
      When I request cross-file consistency validation
      Then the validation should pass with warnings
      And the validation report should indicate "1" consistency warnings
      And the validation report should include the warning "Feature 'Validation Reporting' described in component.md has no corresponding feature file"

    Example: Validating extra feature files
      Given I have a "component.md" file that describes features:
        | Feature Name                  |
        | Component Package Validation  |
        | File-Specific Validation      |
      And I have feature files for:
        | Feature Name                  |
        | Component Package Validation  |
        | File-Specific Validation      |
        | Validation Reporting          |
      When I request cross-file consistency validation
      Then the validation should pass with warnings
      And the validation report should indicate "1" consistency warnings
      And the validation report should include the warning "Feature file 'Validation Reporting' exists but is not described in component.md"