-- knowledgecenter db, ticket_systems schema, ticket_tags table creation script
create table ticket_systems.ticket_tags (
    ticket_id BIGINT not null REFERENCES ticket_systems.tickets(id) on delete cascade,
    tag_id BIGINT not null REFERENCES ticket_systems.tags(id) on delete cascade,
    category VARCHAR(100),
    created_at TIMESTAMPTZ not null default NOW(),
    constraint pk_ticket_tags primary key (ticket_id, tag_id)
);
create index idx_ticket_tags_ticket_id on ticket_systems.ticket_tags(ticket_id);
create index idx_ticket_tags_tag_id on ticket_systems.ticket_tags(tag_id);
create index idx_ticket_tags_category on ticket_systems.ticket_tags(category);

COMMENT ON TABLE ticket_systems.ticket_tags IS 'junction table associating tickets with tags';
COMMENT ON COLUMN ticket_systems.ticket_tags.ticket_id IS 'foreign key referencing tickets table';
COMMENT ON COLUMN ticket_systems.ticket_tags.tag_id IS 'foreign key referencing tags table';
COMMENT ON COLUMN ticket_systems.ticket_tags.category IS 'optional category for the tag association';
COMMENT ON COLUMN ticket_systems.ticket_tags.created_at IS 'record creation timestamp';

-- knowledgecenter db, ticket_systems schema, entry_tags table creation script
create table ticket_systems.entry_tags (
    entry_id BIGINT not null REFERENCES ticket_systems.ticket_entries(id) on delete cascade,
    tag_id BIGINT not null REFERENCES ticket_systems.tags(id) on delete cascade,
    category VARCHAR(100),
    created_at TIMESTAMPTZ not null default NOW(),
    constraint pk_entry_tags primary key (entry_id, tag_id)
);
create index idx_entry_tags_entry_id on ticket_systems.entry_tags(entry_id);
create index idx_entry_tags_tag_id on ticket_systems.entry_tags(tag_id);
create index idx_entry_tags_category on ticket_systems.entry_tags(category);
COMMENT ON TABLE ticket_systems.entry_tags IS 'junction table associating ticket entries with tags';
COMMENT ON COLUMN ticket_systems.entry_tags.entry_id IS 'foreign key referencing ticket_entires table';
COMMENT ON COLUMN ticket_systems.entry_tags.tag_id IS 'foreign key referencing tags table';
COMMENT ON COLUMN ticket_systems.entry_tags.category IS 'optional category for the tag association';
COMMENT ON COLUMN ticket_systems.entry_tags.created_at IS 'record creation timestamp';