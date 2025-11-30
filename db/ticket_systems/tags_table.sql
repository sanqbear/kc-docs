-- knowledgecenter db, ticket_systems schema, tags table creation script
create table ticket_systems.tags (
    id BIGINT generated always as identity primary key,
    name VARCHAR(255) not null,
    color_code VARCHAR(7),

    is_deleted BOOLEAN not null default false,
    created_at TIMESTAMPTZ not null default NOW(),
    updated_at TIMESTAMPTZ not null default NOW()
);
create index idx_tags_name on ticket_systems.tags(name);
create index idx_tags_is_deleted on ticket_systems.tags(is_deleted);
create trigger trg_tags_update_at
    before update on ticket_systems.tags
    for each row execute function ticket_systems.update_timestamp();

COMMENT ON TABLE ticket_systems.tags IS 'table storing tags for categorizing and labeling entities';
COMMENT ON COLUMN ticket_systems.tags.name IS 'name of the tag';
COMMENT ON COLUMN ticket_systems.tags.color_code IS 'hex color code associated with the tag for UI representation';
COMMENT ON COLUMN ticket_systems.tags.is_deleted IS 'flag indicating if the tag is logically deleted';
COMMENT ON COLUMN ticket_systems.tags.created_at IS 'record creation timestamp';
COMMENT ON COLUMN ticket_systems.tags.updated_at IS 'record last update timestamp';