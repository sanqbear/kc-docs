-- knowledgecenter DB, kc_generic scheme, departments table creation script
create table departments (
    id INT generated always as identity primary key,
    public_id VARCHAR(36) not null unique,

    name JSONB not null default '{}',
    email VARCHAR(255),

    leader_user_id INT references users(id),
    parent_department_id INT references departments(id),

    is_visible BOOLEAN not null default true,
    is_deleted BOOLEAN not null default false,

    created_at TIMESTAMPTZ not null default now(),
    updated_at TIMESTAMPTZ not null default now(),

    unique (parent_department_id, name)
);

create index idx_departments_leader_user_id on departments(leader_user_id);
create index idx_departments_parent_department_id on departments(parent_department_id);
create index idx_departments_is_visible on departments(is_visible);
create index idx_departments_is_deleted on departments(is_deleted);
create index idx_departments_name_gin on departments using gin (name);

COMMENT ON TABLE departments IS 'department information table';
COMMENT ON COLUMN departments.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN departments.public_id IS 'public unique identifier, unique department codes for organizational structure';
COMMENT ON COLUMN departments.name IS 'department name in multiple languages, stored as JSONB. Example: {"en-US": "Sales", "ko-KR": "영업", "ja-JP": "営業", "zh-CN": "销售"}';
COMMENT ON COLUMN departments.email IS 'department email address';
COMMENT ON COLUMN departments.leader_user_id IS 'foreign key referencing users table, indicates the leader of the department';
COMMENT ON COLUMN departments.parent_department_id IS 'self-referencing foreign key for hierarchical department structure';
COMMENT ON COLUMN departments.is_visible IS 'flag indicating if the department is visible in the organization chart';
COMMENT ON COLUMN departments.is_deleted IS 'flag indicating if the department is logically deleted';
COMMENT ON COLUMN departments.created_at IS 'timestamp when the department record was created';
COMMENT ON COLUMN departments.updated_at IS 'timestamp when the department record was last updated';