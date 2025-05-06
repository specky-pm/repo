# Specky Repository Documentation

This directory contains comprehensive documentation for the Specky Repository, a container for component specifications following the Specky format.

## Documentation Overview

The documentation is organized into the following sections:

### 1. [Architecture Documentation](architecture-documentation.md)

The architecture documentation provides a detailed explanation of the system's components and their interactions. It covers:

- System overview and purpose
- High-level architecture with component diagrams
- Data model and database schema
- API design and endpoints
- Storage strategy and considerations
- Security and performance considerations
- Design decisions and rationale
- Deployment architecture
- Monitoring and observability

This document is primarily intended for developers, architects, and technical stakeholders who need to understand the system's internal structure and design decisions.

### 2. [User Guide](user-guide.md)

The user guide provides step-by-step instructions for using the Specky Repository. It covers:

- Publishing components to the repository
- Retrieving components from the repository
- Listing available components and versions
- Troubleshooting common issues

This document is intended for end users who need to interact with the Specky Repository, whether they are publishing their own components or retrieving components for use in their projects.

### 3. API Documentation

The API documentation is available through Swagger UI when the application is running. It provides:

- Interactive documentation for all API endpoints
- Request and response examples
- Parameter descriptions and validation rules
- Status codes and error responses

To access the API documentation, navigate to:
```
http://localhost:8080/swagger-ui.html
```

## Using This Documentation

- **For developers**: Start with the architecture documentation to understand the system's design and implementation.
- **For users**: Start with the user guide to learn how to use the Specky Repository.
- **For API integration**: Use the Swagger UI documentation to understand the API endpoints and how to interact with them.

## Contributing to Documentation

When contributing to this documentation, please follow these guidelines:

1. Use Markdown format for all documentation files
2. Use Mermaid diagrams for visual representations
3. Keep the documentation up-to-date with the codebase
4. Follow the existing structure and style

## License

This documentation is licensed under the MIT License. See the LICENSE file in the root directory for details.