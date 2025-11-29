CREATE TABLE managements.api_permissions (
    id  BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    method VARCHAR(10) NOT NULL,          -- 예: 'GET', 'POST', '*'
    path_pattern VARCHAR(255) NOT NULL,   -- Chi 라우터 패턴 (예: '/api/v1/users/{id}')
    required_roles TEXT[] NOT NULL,       -- 허용된 역할 배열 (예: '{admin, manager}')
    description JSONB DEFAULT '{}',  -- 다국어 설명 저장용 JSONB 필드
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- method와 path_pattern 조합은 유일해야 함
    CONSTRAINT uq_method_path UNIQUE (method, path_pattern)
);

CREATE INDEX idx_api_perm_path ON managements.api_permissions(path_pattern);

CREATE TRIGGER trg_api_permissions_update_at
    BEFORE UPDATE ON managements.api_permissions
    FOR EACH ROW EXECUTE FUNCTION managements.update_timestamp();

COMMENT ON TABLE managements.api_permissions IS 'API endpoint permissions table defining access control based on HTTP method, path pattern, and required user roles';
COMMENT ON COLUMN managements.api_permissions.method IS 'HTTP method for the API endpoint (e.g., GET, POST, *)';
COMMENT ON COLUMN managements.api_permissions.path_pattern IS 'Chi router pattern for the API endpoint (e.g., /api/v1/users/{id})';
COMMENT ON COLUMN managements.api_permissions.required_roles IS 'Array of roles required to access the API endpoint (e.g., {admin, manager})';
COMMENT ON COLUMN managements.api_permissions.description IS 'Multilingual description of the API permission stored as JSONB';
COMMENT ON COLUMN managements.api_permissions.created_at IS 'Record creation timestamp';
COMMENT ON COLUMN managements.api_permissions.updated_at IS 'Record last update timestamp';