# Stage 1: Build the application
FROM gradle:8.7-jdk21 AS build
WORKDIR /app

# Copy gradle configuration files
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle

# Download dependencies (this layer will be cached)
RUN ./gradlew dependencies --no-daemon

# Copy source code
COPY src ./src

# Build the application
RUN ./gradlew build --no-daemon -x test

# Stage 2: Create the runtime image
FROM eclipse-temurin:21-jre-alpine

# Add a non-root user to run the application
RUN addgroup -S specky && adduser -S specky -G specky

# Set working directory
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Set ownership to the non-root user
RUN chown -R specky:specky /app

# Switch to non-root user
USER specky

# Configure health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# Expose the application port
EXPOSE 8080

# Set the entrypoint
ENTRYPOINT ["java", "-jar", "app.jar"]