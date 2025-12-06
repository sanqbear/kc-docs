create type ticket_systems.entry_type as enum ('COMMENT', 'FILE', 'SCHEDULE', 'EVENT');
create type ticket_systems.content_format as enum ('PLAIN_TEXT', 'MARKDOWN', 'HTML', 'NONE');

CREATE TABLE ticket_systems.ticket_entries (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    ticket_id BIGINT NOT NULL REFERENCES ticket_systems.tickets(id) ON DELETE CASCADE,
    author_user_id BIGINT REFERENCES organizations.users(id),
    parent_entry_id BIGINT REFERENCES ticket_systems.ticket_entries(id) ON DELETE SET NULL,

    entry_type ticket_systems.entry_type NOT NULL,
    format ticket_systems.content_format DEFAULT 'NONE',

    body TEXT,
    payload JSONB NOT NULL DEFAULT '{}'::jsonb,
    
    search_vector tsvector,

    is_deleted BOOLEAN NOT NULL DEFAULT false,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ticket_entries_ticket_id ON ticket_systems.ticket_entries(ticket_id);
CREATE INDEX idx_ticket_entries_author ON ticket_systems.ticket_entries(author_user_id);
CREATE INDEX idx_ticket_entries_parent ON ticket_systems.ticket_entries(parent_entry_id);
CREATE INDEX idx_ticket_entries_type ON ticket_systems.ticket_entries(entry_type);
CREATE INDEX idx_ticket_entries_created_at ON ticket_systems.ticket_entries(created_at);
create trigger trg_ticket_entries_updated_at
    before update on ticket_systems.ticket_entries
    for each row execute function ticket_systems.update_timestamp();
DROP TRIGGER IF EXISTS trg_ticket_entries_search_vector ON ticket_systems.ticket_entries;
CREATE TRIGGER trg_ticket_entries_search_vector
    BEFORE INSERT OR UPDATE ON ticket_systems.ticket_entries
    FOR EACH ROW EXECUTE FUNCTION ticket_systems.update_entry_search_vector();

DROP INDEX IF EXISTS idx_ticket_entries_search;
CREATE INDEX idx_ticket_entries_search ON ticket_systems.ticket_entries USING GIN (search_vector);
CREATE INDEX idx_ticket_entries_body_trgm ON ticket_systems.ticket_entries USING GIN (body extensions.gin_trgm_ops);
CREATE INDEX idx_ticket_entries_payload_gin ON ticket_systems.ticket_entries USING GIN (payload);

COMMENT ON TABLE ticket_systems.ticket_entries IS 'table storing entries (comments, files, schedules, events) associated with tickets';
COMMENT ON COLUMN ticket_systems.ticket_entries.ticket_id IS 'foreign key referencing tickets table';
COMMENT ON COLUMN ticket_systems.ticket_entries.author_user_id IS 'foreign key referencing users table for the author
of the entry';
COMMENT ON COLUMN ticket_systems.ticket_entries.parent_entry_id IS 'self-referencing foreign key for hierarchical entries (such as comments replying to other comments)';
COMMENT ON COLUMN ticket_systems.ticket_entries.entry_type IS 'type of the ticket entry (comment, file, schedule, event)';
COMMENT ON COLUMN ticket_systems.ticket_entries.format IS 'format of the body content (plain_text, markdown, html, none)';
COMMENT ON COLUMN ticket_systems.ticket_entries.body IS 'main content of the ticket entry';
COMMENT ON COLUMN ticket_systems.ticket_entries.payload IS 'additional structured data for the entry in JSONB format';
COMMENT ON COLUMN ticket_systems.ticket_entries.search_vector IS 'tsvector column for full-text search indexing';
COMMENT ON COLUMN ticket_systems.ticket_entries.is_deleted IS 'flag indicating if the entry is logically deleted';
COMMENT ON COLUMN ticket_systems.ticket_entries.created_at IS 'record creation timestamp';
COMMENT ON COLUMN ticket_systems.ticket_entries.updated_at IS 'record last update timestamp';