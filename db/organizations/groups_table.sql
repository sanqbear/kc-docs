-- knowledgecenter DB, organizations schema, groups table creation table script
create table organizations.groups (
    id int generated always as identity primary key,
    public_id VARCHAR(100) unique not null,
    name JSONB not null default '{}'::JSONB,
    description JSONB not null default '{}'::JSONB,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create index idx_groups_public_id on organizations.groups(public_id);
create index idx_groups_name_gin on organizations.groups using GIN ((name::text) gin_trgm_ops);
create index idx_groups_description_gin on organizations.groups using GIN ((description::text) gin_trgm_ops);

create trigger trg_groups_update_at
    before update on organizations.groups
    for each row execute function organizations.update_timestamp();

COMMENT ON TABLE organizations.groups IS 'table storing user groups for organizing users';
COMMENT ON COLUMN organizations.groups.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN organizations.groups.name IS 'group name in multiple languages, stored as JSONB. Example: {"en-US": "Developers", "ko-KR": "개발자", "ja-JP": "開発者", "zh-CN": "开发者"}';
COMMENT ON COLUMN organizations.groups.description IS 'group description in multiple languages, stored as JSONB. Example: {"en-US": "Group for all developers", "ko-KR": "모든 개발자를 위한 그룹", "ja-JP": "すべての開発者のためのグループ", "zh-CN": "所有开发人员的组"}';
COMMENT ON COLUMN organizations.groups.created_at IS 'record creation timestamp';
COMMENT ON COLUMN organizations.groups.updated_at IS 'record last update timestamp';
COMMENT ON COLUMN organizations.groups.public_id IS 'public unique identifier for the group';

