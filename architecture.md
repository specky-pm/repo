# Specky Repository MVP Architecture

The Specky Repository is a container for component specifications following the Specky format.
A publicly accessible instance will be hosted in the cloud.

The Specky Repository can also be installed as a private instance on private infrastructure if desired.

## System Context

The Specky Repository will be hosted in the cloud and will only connect to a database for persistence.

## Constraints

Since this is an MVP the only contstraint is that it should be small and simple.

## Quality (non-functional) Requirements

The system should be small and simple. It will be thrown away in the future.

## Solution Strategy

To keep the repository small and simple, the following design decisions have been made:
- Programming Language: Java 17
- Frameworks: Spring Boot with WebMVC and DataJPA
- Database: Postgres17
- Packaging: Docker

