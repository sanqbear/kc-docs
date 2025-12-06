-- knowledgecenter DB, organizations schema, common_codes table creation script
create table organizations.common_codes (
    id INT generated always as identity primary key,
    category VARCHAR(100) not null,
    code VARCHAR(100) not null,
    
    name JSONB not null default '{}',
    description JSONB not null default '{}',
    extra_payload JSONB not null default '{}',
    
    sort_order INT not null default 0,
    
    created_at TIMESTAMPTZ not null default NOW(),
    updated_at TIMESTAMPTZ not null default NOW(),
    
    constraint uq_common_codes_category_code unique (category, code)
);

create unique index idx_common_codes_category_code on organizations.common_codes(category, code);
drop index if exists idx_common_codes_name_gin;
create index idx_common_codes_name_gin on organizations.common_codes using GIN ((name::text) extensions.gin_trgm_ops);

create trigger trg_common_codes_update_at
    before update on organizations.common_codes
    for each row execute function organizations.update_timestamp();

COMMENT ON TABLE organizations.common_codes IS 'common codes table for various categories';
COMMENT ON COLUMN organizations.common_codes.id IS 'internal unique sequence identifier, using on JOIN';
COMMENT ON COLUMN organizations.common_codes.category IS 'category of the common code, e.g., RANK, DUTY, TITLE, POSITION, LOCATION';
COMMENT ON COLUMN organizations.common_codes.code IS 'code value within the category';
COMMENT ON COLUMN organizations.common_codes.name IS 'name of the code in multiple languages, stored as JSONB. Example: {"en-US": "Manager", "ko-KR": "매니저", "ja-JP": "マネージャー", "zh-CN": "经理"}';
COMMENT ON COLUMN organizations.common_codes.description IS 'description of the code in multiple languages, stored as JSONB';
COMMENT ON COLUMN organizations.common_codes.extra_payload IS 'additional data related to the code, stored as JSONB. Example: {"locale": "en-US", "timezone": "America/New_York"}';
COMMENT ON COLUMN organizations.common_codes.sort_order IS 'sorting order for displaying codes within the same category';
COMMENT ON COLUMN organizations.common_codes.created_at IS 'timestamp when the record was created';
COMMENT ON COLUMN organizations.common_codes.updated_at IS 'timestamp when the record was last updated';

