-- Migration: Create ai_tools table
-- Description: Stores information about AI development tools tracked in the application
-- Created: 2024-01-15
-- Author: Aleksandar Paytalov

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
-- Validation constraints
-- ============================================

-- Ensure slug is lowercase with hyphens only
ALTER TABLE ai_tools
ADD CONSTRAINT slug_format_check
CHECK (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$');

-- Ensure official_url starts with http:// or https://
ALTER TABLE ai_tools
ADD CONSTRAINT url_format_check
CHECK (official_url ~ '^https?://');

-- ============================================
-- Triggers for updated_at timestamp
-- ============================================

-- Function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to call the function before UPDATE
CREATE TRIGGER update_ai_tools_updated_at
  BEFORE UPDATE ON ai_tools
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- Migration complete
-- ============================================
-- Table: ai_tools created successfully
-- Indexes: Automatic indexes on id, name, slug
-- Constraints: CHECK constraints for slug and URL formats
-- Triggers: Auto-update updated_at timestamp
