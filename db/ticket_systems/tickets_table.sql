create type ticket_systems.ticket_status as enum ('OPEN', 'WAITING_FOR_INFO', 'IN_PROGRESS', 'RESOLVED', 'CLOSED', 'REOPENED');
create type ticket_systems.ticket_priority as enum ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');
create type ticket_systems.ticket_request_type as enum ('BUG', 'MAINTENANCE', 'FEATURE_REQUEST', 'GENERAL_INQUIRY');

-- knowledgecenter DB, ticket_systems schema, tickets table creation script
create table ticket_systems.tickets (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    public_id UUID not null default uuidv7(),

    title VARCHAR(255) not null,

    assigned_user_id INT,

    status ticket_systems.ticket_status not null default 'OPEN',    
    priority ticket_systems.ticket_priority not null default 'MEDIUM',
    request_type ticket_systems.ticket_request_type not null default 'GENERAL_INQUIRY',

    due_date TIMESTAMPTZ,

    created_at TIMESTAMPTZ not null default NOW(),
    updated_at TIMESTAMPTZ not null default NOW()
);

create index idx_tickets_assigned_user_id on ticket_systems.tickets(assigned_user_id);
create index idx_tickets_status on ticket_systems.tickets(status);
create index idx_tickets_priority on ticket_systems.tickets(priority);
create index idx_tickets_request_type on ticket_systems.tickets(request_type);
create index idx_tickets_due_date on ticket_systems.tickets(due_date);
create index idx_tickets_title_gin on ticket_systems.tickets using GIN (title extensions.gin_trgm_ops);

create trigger trg_tickets_update_at
    before update on ticket_systems.tickets
    for each row execute function ticket_systems.update_timestamp();

COMMENT ON TABLE ticket_systems.tickets IS 'support tickets table';
COMMENT ON COLUMN ticket_systems.tickets.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN ticket_systems.tickets.public_id IS 'public unique identifier, UUIDv7 format';
COMMENT ON COLUMN ticket_systems.tickets.title IS 'title of the support ticket';
COMMENT ON COLUMN ticket_systems.tickets.assigned_user_id IS 'foreign key referencing users table, indicates the user assigned to the ticket';
COMMENT ON COLUMN ticket_systems.tickets.status IS 'current status of the ticket';
COMMENT ON COLUMN ticket_systems.tickets.priority IS 'priority level of the ticket';
COMMENT ON COLUMN ticket_systems.tickets.request_type IS 'type of request for the ticket';
COMMENT ON COLUMN ticket_systems.tickets.due_date IS 'due date for resolving the ticket';

COMMENT ON COLUMN ticket_systems.tickets.created_at IS 'record creation timestamp';
COMMENT ON COLUMN ticket_systems.tickets.updated_at IS 'record last update timestamp';
