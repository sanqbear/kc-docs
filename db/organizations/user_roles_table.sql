-- knowledgecenter DB, organizations schema, user roles table creation script
create table organizations.user_roles (
    user_id int references organizations.users(id) on delete cascade,
    role_id int references organizations.roles(id) on delete cascade,
    assigned_by int references organizations.users(id) on delete set null,
    assigned_at timestamptz default now(),
    primary key (user_id, role_id)
);

create index idx_user_roles_user_id on organizations.user_roles(user_id);
create index idx_user_roles_role_id on organizations.user_roles(role_id);

COMMENT ON TABLE organizations.user_roles IS 'mapping table between users and their assigned roles';
COMMENT ON COLUMN organizations.user_roles.user_id IS 'reference to users.id';
COMMENT ON COLUMN organizations.user_roles.role_id IS 'reference to roles.id';
COMMENT ON COLUMN organizations.user_roles.assigned_by IS 'reference to users.id who assigned the role';
COMMENT ON COLUMN organizations.user_roles.assigned_at IS 'timestamp when the role was assigned';

