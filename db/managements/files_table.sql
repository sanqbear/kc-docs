CREATE TABLE managements.files (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    public_id UUID NOT NULL DEFAULT uuidv7(),

    storage_id BIGINT NOT NULL REFERENCES managements.file_storages(id) ON DELETE RESTRICT,

    relative_path VARCHAR(1000) NOT NULL,

    original_filename VARCHAR(500) NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    file_size BIGINT NOT NULL,

    checksum_sha256 VARCHAR(64) NOT NULL,

    uploaded_by INT NOT NULL REFERENCES organizations.users(id) ON DELETE RESTRICT,

    metadata JSONB NOT NULL DEFAULT '{}'::jsonb,

    download_count BIGINT NOT NULL DEFAULT 0,
    last_accessed_at TIMESTAMPTZ,

    is_public BOOLEAN NOT NULL DEFAULT false,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    deleted_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_files_public_id UNIQUE (public_id),
    CONSTRAINT uq_files_storage_path UNIQUE (storage_id, relative_path),
    CONSTRAINT chk_files_size_positive CHECK (file_size > 0)
);

CREATE INDEX idx_files_storage_id ON managements.files(storage_id);
CREATE INDEX idx_files_uploaded_by ON managements.files(uploaded_by);
CREATE INDEX idx_files_mime_type ON managements.files(mime_type);
CREATE INDEX idx_files_checksum ON managements.files(checksum_sha256);
CREATE INDEX idx_files_is_deleted ON managements.files(is_deleted);
CREATE INDEX idx_files_created_at ON managements.files(created_at DESC);
CREATE INDEX idx_files_last_accessed ON managements.files(last_accessed_at DESC NULLS LAST);
CREATE INDEX idx_files_original_filename_gin ON managements.files USING GIN (original_filename extensions.gin_trgm_ops);
CREATE INDEX idx_files_metadata_gin ON managements.files USING GIN (metadata);

CREATE TRIGGER trg_files_update_at
    BEFORE UPDATE ON managements.files
    FOR EACH ROW EXECUTE FUNCTION managements.update_timestamp();

COMMENT ON TABLE managements.files IS 'metadata table for uploaded files stored across various storage backends';
COMMENT ON COLUMN managements.files.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN managements.files.public_id IS 'public unique identifier, UUIDv7 format, used for external API references and download URLs';
COMMENT ON COLUMN managements.files.storage_id IS 'foreign key referencing file_storages table, indicates which storage backend holds this file';
COMMENT ON COLUMN managements.files.relative_path IS 'relative path within the storage backend (e.g., 2024/01/15/abc123.pdf). Combined with storage base_path to form full path';
COMMENT ON COLUMN managements.files.original_filename IS 'original filename as uploaded by the user, preserved for download purposes';
COMMENT ON COLUMN managements.files.mime_type IS 'MIME type of the file (e.g., image/jpeg, application/pdf, text/plain)';
COMMENT ON COLUMN managements.files.file_size IS 'size of the file in bytes';
COMMENT ON COLUMN managements.files.checksum_sha256 IS 'SHA-256 checksum of the file contents for integrity verification and duplicate detection';
COMMENT ON COLUMN managements.files.uploaded_by IS 'foreign key referencing users table, indicates who uploaded the file';
COMMENT ON COLUMN managements.files.metadata IS 'additional file metadata in JSONB format. May include: {"width":1920,"height":1080,"duration":120,"thumbnail_path":"..."}, or custom application-specific metadata';
COMMENT ON COLUMN managements.files.download_count IS 'number of times this file has been downloaded or accessed';
COMMENT ON COLUMN managements.files.last_accessed_at IS 'timestamp of the last download or access, useful for identifying unused files';
COMMENT ON COLUMN managements.files.is_public IS 'flag indicating if the file is publicly accessible without authentication';
COMMENT ON COLUMN managements.files.is_deleted IS 'flag indicating if the file is logically deleted (soft delete)';
COMMENT ON COLUMN managements.files.deleted_at IS 'timestamp when the file was marked as deleted, NULL if not deleted';
COMMENT ON COLUMN managements.files.created_at IS 'record creation timestamp, also represents the upload time';
COMMENT ON COLUMN managements.files.updated_at IS 'record last update timestamp';
