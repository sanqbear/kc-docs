create type ticket_status as enum ('OPEN', 'WAITING_FOR_INFO', 'IN_PROGRESS', 'RESOLVED', 'CLOSED', 'REOPENED');
create type ticket_priority as enum ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');
create type ticket_request_type as enum ('BUG', 'MAINTENANCE', 'FEATURE_REQUEST', 'GENERAL_INQUIRY');

-- knowledgecenter DB, kc_generic scheme, tickets table creation script
create table tickets (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    public_id UUID not null default uuidv7(),

    title VARCHAR(255) not null,

    assigned_user_id INT,

    status ticket_status not null default 'OPEN',    
    priority ticket_priority not null default 'MEDIUM',
    request_type ticket_request_type not null default 'GENERAL_INQUIRY',

    due_date TIMESTAMPTZ,

    created_at TIMESTAMPTZ not null default NOW(),
    updated_at TIMESTAMPTZ not null default NOW()
);

create index idx_tickets_assigned_user_id on tickets(assigned_user_id);
create index idx_tickets_status on tickets(status);
create index idx_tickets_priority on tickets(priority);
create index idx_tickets_request_type on tickets(request_type);
create index idx_tickets_due_date on tickets(due_date);
create index idx_tickets_title_gin on tickets using GIN (title gin_trgm_ops);

create trigger trg_tickets_update_at
    before update on tickets
    for each row execute function update_timestamp();

COMMENT ON TABLE tickets IS 'support tickets table';
COMMENT ON COLUMN tickets.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN tickets.public_id IS 'public unique identifier, UUIDv7 format';
COMMENT ON COLUMN tickets.title IS 'title of the support ticket';
COMMENT ON COLUMN tickets.assigned_user_id IS 'foreign key referencing users table, indicates the user assigned to the ticket';
COMMENT ON COLUMN tickets.status IS 'current status of the ticket';
COMMENT ON COLUMN tickets.priority IS 'priority level of the ticket';
COMMENT ON COLUMN tickets.request_type IS 'type of request for the ticket';
COMMENT ON COLUMN tickets.due_date IS 'due date for resolving the ticket';

COMMENT ON COLUMN tickets.created_at IS 'record creation timestamp';
COMMENT ON COLUMN tickets.updated_at IS 'record last update timestamp';