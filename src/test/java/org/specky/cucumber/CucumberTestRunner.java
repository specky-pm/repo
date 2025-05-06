package org.specky.cucumber;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

/**
 * Cucumber test runner configuration.
 * This class configures Cucumber to run the feature files and step definitions.
 */
@RunWith(Cucumber.class)
@CucumberOptions(
    features = "src/test/resources/features",
    glue = {"org.specky.cucumber"},
    plugin = {"pretty", "html:build/cucumber-reports/cucumber.html"},
    monochrome = true
)
public class CucumberTestRunner {
    // This class is empty and serves only as a configuration holder
}