-- knowledgecenter DB, organizations schema, group_roles table creation script
create table organizations.group_roles (
    group_id int REFERENCES organizations.groups(id) ON DELETE CASCADE,
    role_id int REFERENCES organizations.roles(id) ON DELETE CASCADE,
    
    assigned_at timestamptz DEFAULT now(),
    assigned_by int REFERENCES organizations.users(id) ON DELETE SET NULL,
    PRIMARY KEY (group_id, role_id)
)

comment on table organizations.group_roles is 'Associative table linking groups to roles for access control';
comment on column organizations.group_roles.group_id is 'References the group';
comment on column organizations.group_roles.role_id is 'References the role assigned to the group';
comment on column organizations.group_roles.assigned_at is 'Timestamp when the role was assigned to the group';
comment on column organizations.group_roles.assigned_by is 'User who assigned the role to the group';

