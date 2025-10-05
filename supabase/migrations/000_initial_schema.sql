-- ============================================
-- AI Feature Tracker - Initial Database Schema
-- ============================================
-- Description: Complete database schema for AI Feature Tracker MVP
-- Version: 1.0.0
-- Created: 2024-01-15
-- Author: Aleksandar Paytalov
--
-- This migration creates:
-- - ai_tools table (stores 15 AI development tools)
-- - feature_updates table (stores feature announcements)
-- - All indexes for query optimization
-- - Foreign key relationships
-- - Triggers for automatic timestamp updates
-- - Row Level Security policies
--
-- Execution: Run this file in Supabase SQL Editor
-- ============================================

-- ============================================
-- SECTION 1: CREATE TABLES
-- ============================================

-- ============================================
-- Table: ai_tools
-- Description: Core table storing AI development tool information
-- ============================================

CREATE TABLE IF NOT EXISTS ai_tools (
  -- Primary identifier
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Tool identification
  name VARCHAR(255) NOT NULL UNIQUE,
  slug VARCHAR(255) NOT NULL UNIQUE,

  -- Tool details
  description TEXT,
  official_url VARCHAR(255) NOT NULL,
  logo_url VARCHAR(255),

  -- Tracking timestamps
  last_checked_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- ============================================
-- Table comment
-- ============================================
COMMENT ON TABLE ai_tools IS 'Stores information about AI development tools including name, URL, and tracking metadata';

-- ============================================
-- Column comments
-- ============================================
COMMENT ON COLUMN ai_tools.id IS 'Unique identifier for the tool';
COMMENT ON COLUMN ai_tools.name IS 'Display name of the tool (e.g., Claude, ChatGPT)';
COMMENT ON COLUMN ai_tools.slug IS 'URL-friendly identifier (e.g., claude, chatgpt)';
COMMENT ON COLUMN ai_tools.description IS 'Brief description of the tool';
COMMENT ON COLUMN ai_tools.official_url IS 'Official website URL for the tool';
COMMENT ON COLUMN ai_tools.logo_url IS 'Path to logo image in /public/logos directory';
COMMENT ON COLUMN ai_tools.last_checked_at IS 'Timestamp of last automated feature check';
COMMENT ON COLUMN ai_tools.created_at IS 'Record creation timestamp';
COMMENT ON COLUMN ai_tools.updated_at IS 'Record last update timestamp';

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
-- SECTION 2: VALIDATION CONSTRAINTS
-- ============================================

-- ai_tools constraints
-- Ensure slug is lowercase with hyphens only
ALTER TABLE ai_tools
ADD CONSTRAINT slug_format_check
CHECK (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$');

-- Ensure official_url starts with http:// or https://
ALTER TABLE ai_tools
ADD CONSTRAINT url_format_check
CHECK (official_url ~ '^https?://');

-- feature_updates constraints
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
ADD CONSTRAINT feature_url_format_check
CHECK (official_url IS NULL OR official_url ~ '^https?://');

-- Ensure published_at is not in the future (more than 1 day)
-- Allows small clock skew but prevents obvious mistakes
ALTER TABLE feature_updates
ADD CONSTRAINT published_at_not_future_check
CHECK (published_at <= NOW() + INTERVAL '1 day');

-- ============================================
-- SECTION 3: INDEXES FOR PERFORMANCE
-- ============================================

-- Note: ai_tools table already has automatic unique indexes on id, name, and slug

-- feature_updates indexes
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
-- SECTION 4: TRIGGERS FOR AUTOMATIC UPDATES
-- ============================================

-- Function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to call the function before UPDATE on ai_tools
CREATE TRIGGER update_ai_tools_updated_at
  BEFORE UPDATE ON ai_tools
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- SECTION 5: ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS on both tables
ALTER TABLE ai_tools ENABLE ROW LEVEL SECURITY;
ALTER TABLE feature_updates ENABLE ROW LEVEL SECURITY;

-- ai_tools policies
-- Policy: Allow public read access (anyone can view tools)
CREATE POLICY "Public read access"
  ON ai_tools
  FOR SELECT
  USING (true);

-- Policy: Restrict insert/update/delete to authenticated users only
CREATE POLICY "Authenticated users can insert"
  ON ai_tools
  FOR INSERT
  WITH CHECK (auth.role() = 'authenticated' OR auth.role() = 'service_role');

CREATE POLICY "Authenticated users can update"
  ON ai_tools
  FOR UPDATE
  USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

CREATE POLICY "Authenticated users can delete"
  ON ai_tools
  FOR DELETE
  USING (auth.role() = 'authenticated' OR auth.role() = 'service_role');

-- feature_updates policies
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
-- SECTION 6: VERIFICATION QUERIES
-- ============================================

-- Verify tables exist
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'ai_tools') THEN
    RAISE EXCEPTION 'Table ai_tools was not created';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'feature_updates') THEN
    RAISE EXCEPTION 'Table feature_updates was not created';
  END IF;

  RAISE NOTICE 'Migration completed successfully!';
  RAISE NOTICE 'Tables created: ai_tools, feature_updates';
  RAISE NOTICE 'Indexes created: 3 on feature_updates';
  RAISE NOTICE 'Constraints added: 6 CHECK constraints';
  RAISE NOTICE 'RLS enabled on both tables';
END $$;

-- ============================================
-- MIGRATION COMPLETE
-- ============================================
-- Next steps:
-- 1. Verify tables in Supabase Table Editor
-- 2. Insert 15 AI tools (Task 3.7)
-- 3. Add sample feature updates (Task 3.8)
-- ============================================
