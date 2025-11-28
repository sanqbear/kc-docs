-- Function to update the updated_at timestamp on row modification
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Enable pg_trgm extension for trigram indexing
CREATE EXTENSION IF NOT EXISTS pg_trgm;