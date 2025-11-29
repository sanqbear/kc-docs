-- knowledgecenter DB, organizations schema, users table creation script
create table organizations.users (
	id INT generated always as identity primary key,
	public_id UUID not null default uuidv7(),
    login_id VARCHAR(255) not null,
	
	name JSONB not null default '{}',
		
	email VARCHAR(255) not null,

    password_hash VARCHAR(255),
    is_visible BOOLEAN not null default true,
    is_deleted BOOLEAN not null default false,
	
	dept_id INT,
	
    rank_id INT,
    duty_id INT,
    title_id INT,
    position_id INT,
    location_id INT,

    contact_mobile VARCHAR(255),
    contact_mobile_hash VARCHAR(64),
    contact_mobile_id VARCHAR(4),

    contact_office VARCHAR(255),
    contact_office_hash VARCHAR(64),
    contact_office_id VARCHAR(4),

	created_at TIMESTAMPTZ not null default NOW(),
	updated_at TIMESTAMPTZ not null default NOW(),
	
	constraint uq_users_email unique (email),
	constraint uq_users_public_id unique (public_id),
    constraint uq_users_login_id unique (login_id)
);

create index idx_users_is_visible on organizations.users(is_visible);
create index idx_users_is_deleted on organizations.users(is_deleted);
create unique index idx_users_public_id on organizations.users(public_id);
create unique index idx_users_login_id on organizations.users(login_id);
create index idx_users_phone_hash on organizations.users(contact_mobile_hash);
create index idx_users_phone_id on organizations.users(contact_mobile_id);
create index idx_users_office_hash on organizations.users(contact_office_hash);
create index idx_users_office_id on organizations.users(contact_office_id);
drop index if exists idx_users_name_gin;
create index idx_users_name_gin on organizations.users using GIN ((name::text) gin_trgm_ops);
create trigger trg_users_update_at
    before update on organizations.users
    for each row execute function organizations.update_timestamp();

COMMENT ON TABLE organizations.users IS 'user information table';

COMMENT ON COLUMN organizations.users.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN organizations.users.public_id IS 'public unique identifier, UUIDv7 format';
COMMENT ON COLUMN organizations.users.login_id IS 'user login identifier, unique';
COMMENT ON COLUMN organizations.users.name IS 'user name in multiple languages, stored as JSONB. Example: {"en-US": "John Doe", "ko-KR": "홍길동", "ja-JP": "山田太郎", "zh-CN": "张伟"}';
COMMENT ON COLUMN organizations.users.email IS 'user email address, unique';

COMMENT ON COLUMN organizations.users.dept_id IS 'foreign key referencing departments table';
COMMENT ON COLUMN organizations.users.rank_id IS 'foreign key referencing common_codes table with category named RANK';
COMMENT ON COLUMN organizations.users.duty_id IS 'foreign key referencing common_codes table with category named DUTY';
COMMENT ON COLUMN organizations.users.title_id IS 'foreign key referencing common_codes table with category named TITLE';
COMMENT ON COLUMN organizations.users.position_id IS 'foreign key referencing common_codes table with category named POSITION';
COMMENT ON COLUMN organizations.users.location_id IS 'foreign key referencing common_codes table with category named LOCATION';
COMMENT ON COLUMN organizations.users.contact_mobile IS 'user mobile phone number (encrypted AES-256-GCM, stored by Base64 format)';
COMMENT ON COLUMN organizations.users.contact_mobile_hash IS 'SHA-256 hash of the mobile phone number for quick lookup';
COMMENT ON COLUMN organizations.users.contact_mobile_id IS 'last 4 digits of the mobile phone number for quick partial lookup';

COMMENT ON COLUMN organizations.users.contact_office IS 'user office phone number (encrypted AES-256-GCM, stored by Base64 format)';
COMMENT ON COLUMN organizations.users.contact_office_hash IS 'SHA-256 hash of the office phone number for quick lookup';
COMMENT ON COLUMN organizations.users.contact_office_id IS 'last 4 digits of the office phone number for quick partial lookup';

COMMENT ON COLUMN organizations.users.created_at IS 'record creation timestamp';
COMMENT ON COLUMN organizations.users.updated_at IS 'record last update timestamp';
COMMENT ON COLUMN organizations.users.password_hash IS 'hashed user password using argon2id algorithm, null if using SSO only';
COMMENT ON COLUMN organizations.users.is_visible IS 'flag indicating if the user is visible in the organization chart';
COMMENT ON COLUMN organizations.users.is_deleted IS 'flag indicating if the user is logically deleted';