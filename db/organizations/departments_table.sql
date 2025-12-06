-- knowledgecenter DB, organizations schema, departments table creation script
create table organizations.departments (
    id INT generated always as identity primary key,
    public_id VARCHAR(36) not null unique,

    name JSONB not null default '{}',
    email VARCHAR(255),

    leader_user_id INT references organizations.users(id),
    parent_department_id INT references organizations.departments(id),

    is_visible BOOLEAN not null default true,
    is_deleted BOOLEAN not null default false,

    created_at TIMESTAMPTZ not null default now(),
    updated_at TIMESTAMPTZ not null default now(),

    unique (parent_department_id, name)
);

create index idx_departments_leader_user_id on organizations.departments(leader_user_id);
create index idx_departments_parent_department_id on organizations.departments(parent_department_id);
create index idx_departments_is_visible on organizations.departments(is_visible);
create index idx_departments_is_deleted on organizations.departments(is_deleted);
drop index if exists idx_departments_name_gin;
create index idx_departments_name_gin on organizations.departments using GIN ((name::text) extensions.gin_trgm_ops);

create trigger trg_departments_update_at
    before update on organizations.departments
    for each row execute function organizations.update_timestamp();
COMMENT ON TABLE organizations.departments IS 'department information table';
COMMENT ON COLUMN organizations.departments.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN organizations.departments.public_id IS 'public unique identifier, unique department codes for organizational structure';
COMMENT ON COLUMN organizations.departments.name IS 'department name in multiple languages, stored as JSONB. Example: {"en-US": "Sales", "ko-KR": "영업", "ja-JP": "営業", "zh-CN": "销售"}';
COMMENT ON COLUMN organizations.departments.email IS 'department email address';
COMMENT ON COLUMN organizations.departments.leader_user_id IS 'foreign key referencing users table, indicates the leader of the department';
COMMENT ON COLUMN organizations.departments.parent_department_id IS 'self-referencing foreign key for hierarchical department structure';
COMMENT ON COLUMN organizations.departments.is_visible IS 'flag indicating if the department is visible in the organization chart';
COMMENT ON COLUMN organizations.departments.is_deleted IS 'flag indicating if the department is logically deleted';
COMMENT ON COLUMN organizations.departments.created_at IS 'timestamp when the department record was created';
COMMENT ON COLUMN organizations.departments.updated_at IS 'timestamp when the department record was last updated';

