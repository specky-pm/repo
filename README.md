# Specky Repository

The Specky Repository is a container for component specifications following the Specky format. This MVP (Minimum Viable Product) provides the core functionality for storing and retrieving component packages.

## Features

With the Specky Repository MVP, you can:
- Upload component packages to the repository
- Download specific component versions
- List available components and their versions
- Manage component metadata

## Technology Stack

- Java 21
- Spring Boot 3.x
- PostgreSQL
- Flyway for database migrations
- Swagger/OpenAPI for API documentation

## Documentation

Comprehensive documentation is available in the `docs` directory:

- [Architecture Documentation](docs/architecture-documentation.md) - Detailed explanation of the system's components and design decisions
- [User Guide](docs/user-guide.md) - Step-by-step instructions for publishing and retrieving components
- API Documentation - Available through Swagger UI at `/swagger-ui.html` when the application is running

## Getting Started

### Prerequisites

- Java 21 or higher
- PostgreSQL 17 or higher
- Gradle

### Running the Application

1. Clone the repository
2. Configure the database connection in `src/main/resources/application.properties`
3. Run the application using Gradle:
   ```
   ./gradlew bootRun
   ```
4. Access the API at `http://localhost:8080/api/components`
5. Access the API documentation at `http://localhost:8080/swagger-ui.html`

## Future Enhancements

The following features are planned for future versions:
- Authentication and authorization
- User management
- Component validation
- Component search
- Dependency management
- Metrics and monitoring

## License

This project is licensed under the MIT License - see the LICENSE file for details.