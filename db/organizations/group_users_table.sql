-- knowledgecenter DB, organizations schema, group_users table creation script
create table organizations.group_users (
    group_id int REFERENCES organizations.groups(id) ON DELETE CASCADE,
    user_id int REFERENCES organizations.users(id) ON DELETE CASCADE,
    
    assigned_at timestamptz DEFAULT now(),
    assigned_by int REFERENCES organizations.users(id) ON DELETE SET NULL,
    PRIMARY KEY (group_id, user_id)
);

create index idx_group_users_group_id on organizations.group_users(group_id);
create index idx_group_users_user_id on organizations.group_users(user_id);

COMMENT ON TABLE organizations.group_users IS 'mapping table between groups and their assigned users';
COMMENT ON COLUMN organizations.group_users.group_id IS 'reference to groups.id';
COMMENT ON COLUMN organizations.group_users.user_id IS 'reference to users.id';
COMMENT ON COLUMN organizations.group_users.assigned_at IS 'timestamp when the user was assigned to the group';
COMMENT ON COLUMN organizations.group_users.assigned_by IS 'reference to users.id who assigned the user to the group';

