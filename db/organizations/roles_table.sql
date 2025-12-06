-- knowledgecenter DB, organizations schema, roles table creation script
create table organizations.roles (
    id int generated always as identity primary key,
    name varchar(100) not null unique,
    description JSONB not null default '{}',

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create index idx_roles_name_gin on organizations.roles using GIN ((name::text) extensions.gin_trgm_ops);
create trigger trg_roles_update_at
    before update on organizations.roles
    for each row execute function organizations.update_timestamp();

COMMENT ON TABLE organizations.roles IS 'table storing user roles for access control';
COMMENT ON COLUMN organizations.roles.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN organizations.roles.name IS 'unique name of the role';
COMMENT ON COLUMN organizations.roles.description IS 'role description in multiple languages, stored as JSONB. Example: {"en-US": "Administrator", "ko-KR": "관리자", "ja-JP": "管理者", "zh-CN": "管理员"}';
COMMENT ON COLUMN organizations.roles.created_at IS 'record creation timestamp';
COMMENT ON COLUMN organizations.roles.updated_at IS 'record last update timestamp';
