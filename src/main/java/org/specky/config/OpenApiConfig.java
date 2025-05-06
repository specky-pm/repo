package org.specky.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * Configuration for OpenAPI documentation.
 * This class configures the OpenAPI documentation for the Specky Repository API.
 */
@Configuration
public class OpenApiConfig {

    @Value("${spring.application.name}")
    private String applicationName;

    /**
     * Configures the OpenAPI documentation.
     *
     * @return The OpenAPI configuration
     */
    @Bean
    public OpenAPI speckyOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Specky Repository API")
                        .description("API for the Specky Repository, a container for component specifications following the Specky format")
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("Specky Team")
                                .url("https://github.com/specky")
                                .email("info@specky.org"))
                        .license(new License()
                                .name("MIT License")
                                .url("https://opensource.org/licenses/MIT")))
                .servers(List.of(
                        new Server()
                                .url("/")
                                .description("Local development server")
                ));
    }
}