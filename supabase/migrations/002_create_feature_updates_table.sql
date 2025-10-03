-- Migration: Create feature_updates table
-- Description: Stores feature announcements and updates for AI development tools
-- Created: 2024-01-15
-- Author: Aleksandar Paytalov
-- Dependencies: Requires ai_tools table to exist (001_create_ai_tools_table.sql)

-- ============================================
-- Table: feature_updates
-- Description: Stores feature announcements linked to AI tools
-- ============================================

CREATE TABLE IF NOT EXISTS feature_updates (
  -- Primary identifier
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Foreign key to ai_tools
  tool_id UUID NOT NULL,

  -- Feature details
  title VARCHAR(500) NOT NULL,
  description TEXT NOT NULL,
  official_url VARCHAR(500),

  -- Timestamps
  published_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),

  -- Foreign key constraint
  CONSTRAINT fk_feature_tool
    FOREIGN KEY (tool_id)
    REFERENCES ai_tools(id)
    ON DELETE CASCADE
);

-- ============================================
-- Table comment
-- ============================================
COMMENT ON TABLE feature_updates IS 'Stores feature announcements and updates for AI development tools';

-- ============================================
-- Column comments
-- ============================================
COMMENT ON COLUMN feature_updates.id IS 'Unique identifier for the feature update';
COMMENT ON COLUMN feature_updates.tool_id IS 'Foreign key reference to ai_tools table';
COMMENT ON COLUMN feature_updates.title IS 'Title or headline of the feature update';
COMMENT ON COLUMN feature_updates.description IS 'Detailed description of the feature or update';
COMMENT ON COLUMN feature_updates.official_url IS 'Link to official announcement or documentation';
COMMENT ON COLUMN feature_updates.published_at IS 'Date when the feature was officially announced';
COMMENT ON COLUMN feature_updates.created_at IS 'Record creation timestamp in database';

-- ============================================
-- Indexes for performance
-- ============================================

-- Index on tool_id for fast joins
CREATE INDEX idx_feature_updates_tool_id
  ON feature_updates(tool_id);

-- Index on published_at for date sorting (newest first)
CREATE INDEX idx_feature_updates_published_at
  ON feature_updates(published_at DESC);

-- Composite index for "latest feature per tool" queries
CREATE INDEX idx_feature_updates_tool_published
  ON feature_updates(tool_id, published_at DESC);

-- ============================================
-- Validation constraints
-- ============================================

-- Ensure title is not empty (more than whitespace)
ALTER TABLE feature_updates
ADD CONSTRAINT title_not_empty_check
CHECK (LENGTH(TRIM(title)) > 0);

-- Ensure description is not empty
ALTER TABLE feature_updates
ADD CONSTRAINT description_not_empty_check
CHECK (LENGTH(TRIM(description)) > 0);

-- Ensure official_url is valid format if provided
ALTER TABLE feature_updates
ADD CONSTRAINT url_format_check
CHECK (official_url IS NULL OR official_url ~ '^https?://');

-- Ensure published_at is not in the future (more than 1 day)
-- Allows small clock skew but prevents obvious mistakes
ALTER TABLE feature_updates
ADD CONSTRAINT published_at_not_future_check
CHECK (published_at <= NOW() + INTERVAL '1 day');

-- ============================================
-- Row Level Security (RLS) Setup
-- ============================================

-- Enable RLS on feature_updates table
ALTER TABLE feature_updates ENABLE ROW LEVEL SECURITY;

-- Policy: Allow public read access (anyone can view features)
CREATE POLICY "Public read access"
  ON feature_updates
  FOR SELECT
  USING (true);

-- Policy: Restrict insert/update/delete to authenticated users only
-- (This will be used by the automated cron job with service role key)
CREATE POLICY "Authenticated users can insert"
  ON feature_updates
  FOR INSERT
  WITH CHECK (auth.role() = 'authenticated' OR auth.role() = 'service_role');

CREATE POLICY "Authenticated users can update"
  ON feature_updates
  FOR UPDATE
  USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

CREATE POLICY "Authenticated users can delete"
  ON feature_updates
  FOR DELETE
  USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

-- ============================================
-- Migration complete
-- ============================================
-- Table: feature_updates created successfully
-- Foreign Key: Linked to ai_tools with ON DELETE CASCADE
-- Indexes: 3 indexes created for performance optimization
-- Constraints: 4 CHECK constraints for data validation
-- RLS Policies: Public read, authenticated write access
