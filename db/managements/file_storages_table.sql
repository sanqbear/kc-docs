CREATE TYPE managements.storage_type AS ENUM ('LOCAL', 'S3', 'AZURE_BLOB', 'GCS', 'NFS');
CREATE TYPE managements.storage_status AS ENUM ('ACTIVE', 'READONLY', 'DISABLED');

CREATE TABLE managements.file_storages (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    public_id UUID NOT NULL DEFAULT uuidv7(),

    name VARCHAR(100) NOT NULL,
    storage_type managements.storage_type NOT NULL,

    base_path VARCHAR(500) NOT NULL,

    config JSONB NOT NULL DEFAULT '{}'::jsonb,

    status managements.storage_status NOT NULL DEFAULT 'ACTIVE',

    max_file_size BIGINT,
    allowed_mime_types TEXT[],

    is_default BOOLEAN NOT NULL DEFAULT false,
    is_deleted BOOLEAN NOT NULL DEFAULT false,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_file_storages_public_id UNIQUE (public_id),
    CONSTRAINT uq_file_storages_name UNIQUE (name)
);

CREATE INDEX idx_file_storages_type ON managements.file_storages(storage_type);
CREATE INDEX idx_file_storages_status ON managements.file_storages(status);
CREATE INDEX idx_file_storages_is_default ON managements.file_storages(is_default) WHERE is_default = true;
CREATE INDEX idx_file_storages_is_deleted ON managements.file_storages(is_deleted);
CREATE INDEX idx_file_storages_config_gin ON managements.file_storages USING GIN (config);

CREATE TRIGGER trg_file_storages_update_at
    BEFORE UPDATE ON managements.file_storages
    FOR EACH ROW EXECUTE FUNCTION managements.update_timestamp();

COMMENT ON TABLE managements.file_storages IS 'configuration table for file storage backends (local, S3, Azure Blob, GCS, NFS)';
COMMENT ON COLUMN managements.file_storages.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN managements.file_storages.public_id IS 'public unique identifier, UUIDv7 format';
COMMENT ON COLUMN managements.file_storages.name IS 'unique name identifier for the storage backend';
COMMENT ON COLUMN managements.file_storages.storage_type IS 'type of storage backend (LOCAL, S3, AZURE_BLOB, GCS, NFS)';
COMMENT ON COLUMN managements.file_storages.base_path IS 'base path or URL for the storage backend (e.g., /var/data/uploads, s3://bucket-name, https://account.blob.core.windows.net/container)';
COMMENT ON COLUMN managements.file_storages.config IS 'storage-specific configuration in JSONB format. For S3: {"region":"us-east-1","access_key_id":"...","secret_access_key":"..."}. For LOCAL: {"permissions":"0755"}. For AZURE: {"account_name":"...","account_key":"..."}';
COMMENT ON COLUMN managements.file_storages.status IS 'operational status of the storage (ACTIVE: read/write, READONLY: read only, DISABLED: inaccessible)';
COMMENT ON COLUMN managements.file_storages.max_file_size IS 'maximum allowed file size in bytes for this storage backend, NULL for unlimited';
COMMENT ON COLUMN managements.file_storages.allowed_mime_types IS 'array of allowed MIME types for this storage, NULL for no restrictions. Example: {image/jpeg, image/png, application/pdf}';
COMMENT ON COLUMN managements.file_storages.is_default IS 'flag indicating if this is the default storage backend for new uploads';
COMMENT ON COLUMN managements.file_storages.is_deleted IS 'flag indicating if the storage configuration is logically deleted';
COMMENT ON COLUMN managements.file_storages.created_at IS 'record creation timestamp';
COMMENT ON COLUMN managements.file_storages.updated_at IS 'record last update timestamp';
