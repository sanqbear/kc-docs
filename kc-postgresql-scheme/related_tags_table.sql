-- knowledgecenter db, kc_generic schema, ticket_tags table creation script
create table ticket_tags (
    ticket_id BIGINT not null REFERENCES tickets(id) on delete cascade,
    tag_id BIGINT not null REFERENCES tags(id) on delete cascade,
    category VARCHAR(100),
    created_at TIMESTAMPTZ not null default NOW(),
    constraint pk_ticket_tags primary key (ticket_id, tag_id)
);
create index idx_ticket_tags_ticket_id on ticket_tags(ticket_id);
create index idx_ticket_tags_tag_id on ticket_tags(tag_id);
create index idx_ticket_tags_category on ticket_tags(category);

COMMENT ON TABLE ticket_tags IS 'junction table associating tickets with tags';
COMMENT ON COLUMN ticket_tags.ticket_id IS 'foreign key referencing tickets table';
COMMENT ON COLUMN ticket_tags.tag_id IS 'foreign key referencing tags table';
COMMENT ON COLUMN ticket_tags.category IS 'optional category for the tag association';
COMMENT ON COLUMN ticket_tags.created_at IS 'record creation timestamp';

-- knowledgecenter db, kc_postgresql_scheme schema, entry_tags table creation script
create table entry_tags (
    entry_id BIGINT not null REFERENCES ticket_entires(id) on delete cascade,
    tag_id BIGINT not null REFERENCES tags(id) on delete cascade,
    category VARCHAR(100),
    created_at TIMESTAMPTZ not null default NOW(),
    constraint pk_entry_tags primary key (entry_id, tag_id)
);
create index idx_entry_tags_entry_id on entry_tags(entry_id);
create index idx_entry_tags_tag_id on entry_tags(tag_id);
create index idx_entry_tags_category on entry_tags(category);
COMMENT ON TABLE entry_tags IS 'junction table associating ticket entries with tags';
COMMENT ON COLUMN entry_tags.entry_id IS 'foreign key referencing ticket_entires table';
COMMENT ON COLUMN entry_tags.tag_id IS 'foreign key referencing tags table';
COMMENT ON COLUMN entry_tags.category IS 'optional category for the tag association';
COMMENT ON COLUMN entry_tags.created_at IS 'record creation timestamp';