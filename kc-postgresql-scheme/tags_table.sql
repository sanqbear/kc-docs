-- knowledgecenter db, kc_generic schema, tags table creation script
create table tags (
    id BIGINT generated always as identity primary key,
    name VARCHAR(255) not null,
    color_code VARCHAR(7),

    is_deleted BOOLEAN not null default false,
    created_at TIMESTAMPTZ not null default NOW(),
    updated_at TIMESTAMPTZ not null default NOW()
);
create index idx_tags_name on tags(name);
create index idx_tags_is_deleted on tags(is_deleted);
create trigger trg_tags_update_at
    before update on tags
    for each row execute function update_timestamp();

COMMENT ON TABLE tags IS 'table storing tags for categorizing and labeling entities';
COMMENT ON COLUMN tags.name IS 'name of the tag';
COMMENT ON COLUMN tags.color_code IS 'hex color code associated with the tag for UI representation';
COMMENT ON COLUMN tags.is_deleted IS 'flag indicating if the tag is logically deleted';
COMMENT ON COLUMN tags.created_at IS 'record creation timestamp';
COMMENT ON COLUMN tags.updated_at IS 'record last update timestamp';