-- knowledgecenter DB, organizations schema, user tokens table creation script
create table organizations.user_tokens (
    id BIGINT generated always as identity primary key,
    user_id INT REFERENCES organizations.users(id) on delete cascade,
    token_hash VARCHAR(255) not null,

    expires_at TIMESTAMPTZ not null,
    is_revoked BOOLEAN not null default FALSE,

    replaced_by_token_id BIGINT REFERENCES organizations.user_tokens(id) on delete set null,
    parent_token_id BIGINT REFERENCES organizations.user_tokens(id) on delete set null,         -- token id when first logged in (for tracking token lineage)

    client_ip INET,
    user_agent VARCHAR(1024),

    created_at TIMESTAMPTZ not null default now(),
    updated_at TIMESTAMPTZ not null default now()
);

create index idx_user_tokens_user_id on organizations.user_tokens (user_id);
create index idx_user_tokens_token_hash on organizations.user_tokens (token_hash);

create trigger trg_user_tokens_updated_at
    before update on organizations.user_tokens
    for each row
    execute function organizations.update_timestamp();

COMMENT ON TABLE organizations.user_tokens IS 'Table to store user authentication tokens for session management.';
comment on column organizations.user_tokens.id IS 'Primary key for the user_tokens table.';
COMMENT ON COLUMN organizations.user_tokens.user_id IS 'Reference to the user associated with the token.';
COMMENT ON COLUMN organizations.user_tokens.token_hash IS 'Hashed representation of the authentication token for security.';
COMMENT ON COLUMN organizations.user_tokens.expires_at IS 'Timestamp indicating when the token expires.';
COMMENT ON COLUMN organizations.user_tokens.is_revoked IS 'Flag to indicate if the token has been revoked.';
COMMENT ON COLUMN organizations.user_tokens.replaced_by_token_id IS 'Reference to the token that replaced this token, if any.';
COMMENT ON COLUMN organizations.user_tokens.parent_token_id IS 'Reference to the original token in the token lineage.';
COMMENT ON COLUMN organizations.user_tokens.created_at IS 'Timestamp when the token was created.';
COMMENT ON COLUMN organizations.user_tokens.updated_at IS 'Timestamp when the token was last updated.';
COMMENT ON COLUMN organizations.user_tokens.client_ip IS 'IP address from which the token was issued.';
COMMENT ON COLUMN organizations.user_tokens.user_agent IS 'User agent string of the client that requested the token.';
