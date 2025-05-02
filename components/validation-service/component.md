# Validation Service

## Overview

The Validation Service component ensures the integrity and correctness of component specifications in the Specky repository. It validates the structure and content of component packages against defined schemas, checks for compliance with Specky standards, and provides detailed validation reports. This component is crucial for maintaining the quality and consistency of component specifications in the repository.

## Core Functionality

- Component package structure validation
- spec.json schema validation
- component.md content validation
- datamodel.json schema validation
- Gherkin feature file validation
- Cross-file consistency checking
- Validation reporting

## Features & Use Cases

### Component Package Validation

The component validates complete packages to ensure they meet all requirements and standards:

- Validates component packages during upload or on-demand
- Ensures packages contain all required files (spec.json, component.md)
- Verifies optional files (datamodel.json, tests/*.feature) when present
- Checks overall package structure validity
- Prevents inclusion of extraneous or potentially harmful files
- Enforces package size limits
- Generates comprehensive validation reports with issues and suggestions

### File-Specific Validation

The component performs targeted validation for each file type:

#### spec.json Validation
- Verifies JSON syntax correctness
- Validates against the spec.json schema
- Ensures required fields (name, version, description) are present
- Validates semantic versioning format
- Verifies dependency references and version ranges

#### component.md Validation
- Checks for minimum required sections
- Validates markdown syntax
- Ensures component description adequacy
- Verifies links and references
- Enforces compliance with best practices

#### datamodel.json Validation
- Verifies JSON syntax correctness
- Validates against the datamodel.json schema
- Checks entity definitions and relationships
- Verifies attribute types and constraints
- Ensures referential integrity in relationships

#### Gherkin Feature File Validation
- Validates Gherkin syntax
- Verifies feature file structure (Feature, Rule, Example)
- Ensures scenarios are well-formed
- Checks terminology consistency
- Enforces compliance with Gherkin best practices

### Validation Reporting

The component provides comprehensive reporting capabilities:

- Categorizes issues by severity (error, warning, info)
- Provides clear error messages with line numbers
- Includes suggestions for resolving issues
- Summarizes validation results
- Formats reports for both human and machine consumption
- Presents results in a user-friendly format
- Highlights critical issues requiring attention
- Provides context for each validation rule
- Links to documentation for validation requirements
- Supports filtering and sorting of validation results