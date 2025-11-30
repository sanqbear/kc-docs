-- knowledgecenter db, ticket_systems schema, entry_references table creation script
create table ticket_systems.entry_references (
    source_entry_id BIGINT references ticket_systems.ticket_entries(id) on delete cascade,
    target_entry_id BIGINT REFERENCES ticket_systems.ticket_entries(id) on delete cascade,
    target_ticket_id BIGINT REFERENCES ticket_systems.tickets(id) on delete cascade,
    target_user_id BIGINT REFERENCES ticket_systems.users(id) on delete cascade,
    created_at TIMESTAMPTZ not null default NOW(),
    check (source_entry_id <> target_entry_id),
);\
create index idx_entry_references_source_entry_id on ticket_systems.entry_references(source_entry_id);
create index idx_entry_references_target_entry_id on ticket_systems.entry_references(target_entry_id);
create index idx_entry_references_target_ticket_id on ticket_systems.entry_references(target_ticket_id);
create index idx_entry_references_target_user_id on ticket_systems.entry_references(target_user_id);

COMMENT ON TABLE ticket_systems.entry_references IS 'table storing references from one ticket entry to other entries, tickets, or users';
COMMENT ON COLUMN ticket_systems.entry_references.source_entry_id IS 'foreign key referencing the source ticket entry';
COMMENT ON COLUMN ticket_systems.entry_references.target_entry_id IS 'foreign key referencing the target ticket entry';
COMMENT ON COLUMN ticket_systems.entry_references.target_ticket_id IS 'foreign key referencing the target ticket';
COMMENT ON COLUMN ticket_systems.entry_references.target_user_id IS 'foreign key referencing the target user';
COMMENT ON COLUMN ticket_systems.entry_references.created_at IS 'record creation timestamp';