Feature: File-Specific Validation
  As a component developer
  I want to validate individual files in my component package
  So that I can identify and fix issues in specific files

  Background:
    Given the validation service is available
    And validation schemas are up-to-date

  Rule: spec.json files must be valid against the schema

    Example: Validating a valid spec.json file
      Given I have a "spec.json" file with the following content:
        """
        {
          "name": "Test Component",
          "version": "1.0.0",
          "description": "A test component for validation",
          "dependencies": [
            {
              "name": "Component Storage",
              "version": "^0.1.0"
            }
          ],
          "keywords": [
            "test",
            "validation"
          ]
        }
        """
      When I request validation of the "spec.json" file
      Then the validation should pass
      And the validation report should indicate "0" errors
      And the validation report should indicate "0" warnings

    Example: Validating a spec.json file with missing required fields
      Given I have a "spec.json" file with the following content:
        """
        {
          "name": "Test Component",
          "version": "1.0.0"
        }
        """
      When I request validation of the "spec.json" file
      Then the validation should fail
      And the validation report should indicate "1" errors
      And the validation report should include the error "Missing required field: description"

    Example: Validating a spec.json file with invalid version format
      Given I have a "spec.json" file with the following content:
        """
        {
          "name": "Test Component",
          "version": "1.0",
          "description": "A test component for validation"
        }
        """
      When I request validation of the "spec.json" file
      Then the validation should fail
      And the validation report should indicate "1" errors
      And the validation report should include the error "Invalid semantic version format: 1.0"

  Rule: component.md files must contain required sections and valid markdown

    Example: Validating a valid component.md file
      Given I have a "component.md" file with the following content:
        """
        # Test Component

        ## Overview

        This is a test component for validation.

        ## Core Functionality

        - Feature 1
        - Feature 2

        ## Features & Use Cases

        ### Feature 1

        Description of feature 1.

        ### Feature 2

        Description of feature 2.
        """
      When I request validation of the "component.md" file
      Then the validation should pass
      And the validation report should indicate "0" errors
      And the validation report should indicate "0" warnings

    Example: Validating a component.md file with missing required sections
      Given I have a "component.md" file with the following content:
        """
        # Test Component

        ## Overview

        This is a test component for validation.
        """
      When I request validation of the "component.md" file
      Then the validation should fail
      And the validation report should indicate "2" errors
      And the validation report should include the error "Missing required section: Core Functionality"
      And the validation report should include the error "Missing required section: Features & Use Cases"

    Example: Validating a component.md file with invalid markdown syntax
      Given I have a "component.md" file with the following content:
        """
        # Test Component

        ## Overview

        This is a test component for validation.

        ## Core Functionality

        - Feature 1
        - Feature 2

        ## Features & Use Cases

        ### Feature 1

        Description of feature 1.

        ### Feature 2

        Description of feature 2.

        [Broken link](
        """
      When I request validation of the "component.md" file
      Then the validation should fail
      And the validation report should indicate "1" errors
      And the validation report should include the error "Invalid markdown syntax: Unclosed link"

  Rule: datamodel.json files must be valid against the schema

    Example: Validating a valid datamodel.json file
      Given I have a "datamodel.json" file with the following content:
        """
        {
          "entities": {
            "TestEntity": {
              "description": "A test entity",
              "attributes": {
                "id": {
                  "type": "string",
                  "description": "Unique identifier",
                  "validation": {
                    "required": true
                  }
                },
                "name": {
                  "type": "string",
                  "description": "Entity name",
                  "validation": {
                    "required": true
                  }
                }
              }
            }
          },
          "relationships": []
        }
        """
      When I request validation of the "datamodel.json" file
      Then the validation should pass
      And the validation report should indicate "0" errors
      And the validation report should indicate "0" warnings

    Example: Validating a datamodel.json file with invalid entity definition
      Given I have a "datamodel.json" file with the following content:
        """
        {
          "entities": {
            "TestEntity": {
              "description": "A test entity",
              "attributes": {
                "id": {
                  "type": "invalid_type",
                  "description": "Unique identifier",
                  "validation": {
                    "required": true
                  }
                }
              }
            }
          },
          "relationships": []
        }
        """
      When I request validation of the "datamodel.json" file
      Then the validation should fail
      And the validation report should indicate "1" errors
      And the validation report should include the error "Invalid attribute type: invalid_type"

  Rule: Gherkin feature files must have valid syntax and structure

    Example: Validating a valid feature file
      Given I have a "test.feature" file with the following content:
        """
        Feature: Test Feature
          As a user
          I want to test something
          So that I can ensure it works

          Scenario: Test scenario
            Given I have a test condition
            When I perform a test action
            Then I should see a test result
        """
      When I request validation of the "test.feature" file
      Then the validation should pass
      And the validation report should indicate "0" errors
      And the validation report should indicate "0" warnings

    Example: Validating a feature file with invalid Gherkin syntax
      Given I have a "test.feature" file with the following content:
        """
        Feature: Test Feature
          As a user
          I want to test something
          So that I can ensure it works

          Scenario: Test scenario
            Given I have a test condition
            When I perform a test action
            Invalid step
            Then I should see a test result
        """
      When I request validation of the "test.feature" file
      Then the validation should fail
      And the validation report should indicate "1" errors
      And the validation report should include the error "Invalid Gherkin syntax: Step must start with Given, When, Then, And, or But"