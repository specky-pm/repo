# Specky Repository User Guide

This guide provides instructions for using the Specky Repository to publish and retrieve component packages. The Specky Repository is a container for component specifications following the Specky format.

## Table of Contents

1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [Publishing Components](#publishing-components)
4. [Retrieving Components](#retrieving-components)
5. [Listing Components](#listing-components)
6. [Troubleshooting](#troubleshooting)

## Introduction

The Specky Repository allows you to:
- Publish component packages to a central repository
- Download specific component versions
- List available components and their versions
- Manage component metadata

Components in the Specky Repository follow a standardized format and naming convention, making them easy to discover and use.

## Getting Started

### Prerequisites

- The Specky Repository should be running and accessible
- You should have component packages in ZIP format ready for publishing
- Component packages should follow the Specky format

### Base URL

All API endpoints are relative to the base URL of the Specky Repository:

```
http://localhost:8080/api/components
```

Replace `localhost:8080` with the actual host and port where the Specky Repository is running.

## Publishing Components

### Step 1: Prepare Your Component Package

Before publishing, ensure your component package:
- Is in ZIP format
- Contains all required files according to the Specky format
- Has a valid name and version

Component names typically follow the format `@organization/component-name`, for example:
```
@specky/component-storage
```

Versions must follow semantic versioning (major.minor.patch), for example:
```
1.0.0
```

### Step 2: Publish the Component

You can publish a component using the following methods:

#### Using cURL

```bash
curl -X POST \
  http://localhost:8080/api/components \
  -H "Content-Type: multipart/form-data" \
  -F "name=@specky/component-storage" \
  -F "version=1.0.0" \
  -F "description=A storage component for Specky" \
  -F "packageFile=@/path/to/your/component.zip"
```

#### Using a REST Client

1. Set the request method to `POST`
2. Set the URL to `http://localhost:8080/api/components`
3. Set the content type to `multipart/form-data`
4. Add the following form fields:
   - `name`: The component name (e.g., `@specky/component-storage`)
   - `version`: The component version (e.g., `1.0.0`)
   - `description`: A description of the component (optional)
   - `packageFile`: The component package file (ZIP)
5. Send the request

### Step 3: Verify the Publication

After publishing, you should receive a response with status code `201 Created` and a JSON body containing the component metadata:

```json
{
  "name": "@specky/component-storage",
  "version": "1.0.0",
  "description": "A storage component for Specky",
  "publicationTimestamp": "2025-06-05T13:45:30",
  "updateTimestamp": "2025-06-05T13:45:30"
}
```

## Retrieving Components

### Step 1: Identify the Component to Download

To download a component, you need to know its name and version. You can list available components if you're not sure what's available (see [Listing Components](#listing-components)).

### Step 2: Download the Component

You can download a component using the following methods:

#### Using cURL

```bash
curl -X GET \
  "http://localhost:8080/api/components/download?name=@specky/component-storage&version=1.0.0" \
  -o component.zip
```

#### Using a Web Browser

1. Navigate to the following URL:
   ```
   http://localhost:8080/api/components/download?name=@specky/component-storage&version=1.0.0
   ```
2. The browser should automatically download the component package as a ZIP file

#### Using a REST Client

1. Set the request method to `GET`
2. Set the URL to `http://localhost:8080/api/components/download`
3. Add the following query parameters:
   - `name`: The component name (e.g., `@specky/component-storage`)
   - `version`: The component version (e.g., `1.0.0`)
4. Send the request
5. Save the response body as a ZIP file

### Step 3: Use the Component

After downloading, you can extract the ZIP file and use the component according to your project's requirements.

## Listing Components

### List All Components

To list all available components:

```bash
curl -X GET http://localhost:8080/api/components
```

This will return a JSON response with all components:

```json
{
  "count": 2,
  "components": [
    {
      "name": "@specky/component-storage",
      "version": "1.0.0",
      "description": "A storage component for Specky",
      "publicationTimestamp": "2025-06-05T13:45:30",
      "updateTimestamp": "2025-06-05T13:45:30"
    },
    {
      "name": "@specky/component-ui",
      "version": "2.1.0",
      "description": "A UI component for Specky",
      "publicationTimestamp": "2025-06-04T10:15:20",
      "updateTimestamp": "2025-06-04T10:15:20"
    }
  ]
}
```

### List Component Versions

To list all versions of a specific component:

```bash
curl -X GET "http://localhost:8080/api/components/versions?name=@specky/component-storage"
```

This will return a JSON response with all versions of the specified component:

```json
{
  "count": 3,
  "components": [
    {
      "name": "@specky/component-storage",
      "version": "1.0.0",
      "description": "A storage component for Specky",
      "publicationTimestamp": "2025-06-05T13:45:30",
      "updateTimestamp": "2025-06-05T13:45:30"
    },
    {
      "name": "@specky/component-storage",
      "version": "0.9.0",
      "description": "A storage component for Specky (beta)",
      "publicationTimestamp": "2025-06-01T09:30:15",
      "updateTimestamp": "2025-06-01T09:30:15"
    },
    {
      "name": "@specky/component-storage",
      "version": "0.8.0",
      "description": "A storage component for Specky (alpha)",
      "publicationTimestamp": "2025-05-15T14:20:10",
      "updateTimestamp": "2025-05-15T14:20:10"
    }
  ]
}
```

## Troubleshooting

### Common Issues and Solutions

#### Component Upload Fails

If you encounter issues when uploading a component:

1. **Check the component package size**: The maximum allowed size is 10MB
2. **Verify the component name format**: It should typically follow the format `@organization/component-name`
3. **Verify the version format**: It must follow semantic versioning (e.g., `1.0.0`)
4. **Ensure the package is a valid ZIP file**: Try extracting it locally to verify
5. **Check for server errors**: Look for error messages in the response

#### Component Download Fails

If you encounter issues when downloading a component:

1. **Verify the component exists**: Use the listing endpoints to check if the component and version exist
2. **Check the name and version parameters**: Ensure they match exactly (case-sensitive)
3. **Check for server errors**: Look for error messages in the response

#### API Returns an Error

Common HTTP status codes and their meanings:

- **400 Bad Request**: The request was invalid (check parameters)
- **404 Not Found**: The requested component or version doesn't exist
- **500 Internal Server Error**: A server-side error occurred

### Getting Help

If you continue to experience issues:

1. Check the server logs for more detailed error information
2. Contact the system administrator for assistance
3. Report bugs or issues to the Specky Repository maintainers

## API Reference

For a complete API reference, you can access the Swagger UI documentation at:

```
http://localhost:8080/swagger-ui.html
```

This interactive documentation allows you to:
- View all available endpoints
- See request and response formats
- Test API calls directly from the browser