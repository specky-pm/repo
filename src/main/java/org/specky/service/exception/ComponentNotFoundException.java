package org.specky.service.exception;

/**
 * Exception thrown when a requested component is not found.
 */
public class ComponentNotFoundException extends RuntimeException {

    public ComponentNotFoundException(String message) {
        super(message);
    }

    public ComponentNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}