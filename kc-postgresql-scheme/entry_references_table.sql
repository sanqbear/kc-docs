-- knowledgecenter db, kc_postgresql_scheme schema, entry_references table creation script
create table entry_references (
    source_entry_id BIGINT references ticket_entires(id) on delete cascade,
    target_entry_id BIGINT REFERENCES ticket_entires(id) on delete cascade,
    target_ticket_id BIGINT REFERENCES tickets(id) on delete cascade,
    target_user_id BIGINT REFERENCES users(id) on delete cascade,
    created_at TIMESTAMPTZ not null default NOW(),
    check (source_entry_id <> target_entry_id),
);\
create index idx_entry_references_source_entry_id on entry_references(source_entry_id);
create index idx_entry_references_target_entry_id on entry_references(target_entry_id);
create index idx_entry_references_target_ticket_id on entry_references(target_ticket_id);
create index idx_entry_references_target_user_id on entry_references(target_user_id);

COMMENT ON TABLE entry_references IS 'table storing references from one ticket entry to other entries, tickets, or users';
COMMENT ON COLUMN entry_references.source_entry_id IS 'foreign key referencing the source ticket entry';
COMMENT ON COLUMN entry_references.target_entry_id IS 'foreign key referencing the target ticket entry';
COMMENT ON COLUMN entry_references.target_ticket_id IS 'foreign key referencing the target ticket';
COMMENT ON COLUMN entry_references.target_user_id IS 'foreign key referencing the target user';
COMMENT ON COLUMN entry_references.created_at IS 'record creation timestamp';