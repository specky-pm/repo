-- Create the components table for storing component specifications
CREATE TABLE components (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    version VARCHAR(50) NOT NULL,
    description TEXT,
    package_content BYTEA NOT NULL,
    publication_timestamp TIMESTAMP NOT NULL,
    update_timestamp TIMESTAMP NOT NULL
);

-- Create indexes for efficient querying
CREATE INDEX idx_components_name ON components(name);
CREATE UNIQUE INDEX idx_components_name_version ON components(name, version);