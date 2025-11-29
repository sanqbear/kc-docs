-- Enable pg_trgm extension for trigram indexing

CREATE SCHEMA IF NOT EXISTS organizations;
CREATE SCHEMA IF NOT EXISTS ticket_systems;   
CREATE SCHEMA IF NOT EXISTS extensions;   
CREATE SCHEMA IF NOT EXISTS managements;
CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA extensions;
ALTER DATABASE "knowledgecenter" SET search_path TO "$user", public, extensions;

-- Function to update the updated_at timestamp on row modification
CREATE OR REPLACE FUNCTION organizations.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- Function to update the updated_at timestamp on row modification
CREATE OR REPLACE FUNCTION ticket_systems.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- Function to update the updated_at timestamp on row modification
CREATE OR REPLACE FUNCTION managements.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to update the search_vector column for full-text search
CREATE OR REPLACE FUNCTION ticket_systems.update_entry_search_vector()
RETURNS TRIGGER AS $$
BEGIN
    -- 'english' 대신 'simple' 사용: 
    -- 'simple'은 형태소 분석 없이 띄어쓰기 단위로 단어를 저장하므로 한국어가 깨지지 않습니다.
    -- setweight: A(타이틀급 중요도)는 본문에, B는 메타데이터(payload)에 부여 (예시)
    NEW.search_vector :=
        setweight(to_tsvector('simple', COALESCE(NEW.body, '')), 'A') ||
        setweight(to_tsvector('simple', COALESCE(NEW.payload::text, '')), 'B');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
