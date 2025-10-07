-- ============================================
-- AI Feature Tracker - Seed AI Tools Data
-- ============================================
-- Description: Insert 15 AI development tools
-- Created: 2024-01-15
-- Author: Aleksandar Paytalov
--
-- This seed file inserts the initial 15 AI code assistant tools
-- that will be tracked by the AI Feature Tracker application.
-- ============================================

-- ============================================
-- INSERT AI TOOLS
-- ============================================

INSERT INTO ai_tools (name, slug, description, official_url, logo_url) VALUES

-- 1. Claude (Anthropic)
('Claude', 'claude',
'AI assistant by Anthropic with advanced reasoning capabilities and large context windows. Excels at coding, writing, and analysis tasks.',
'https://claude.ai',
NULL),

-- 2. ChatGPT (OpenAI)
('ChatGPT', 'chatgpt',
'OpenAI''s conversational AI model with advanced language understanding and code generation capabilities. Includes GPT-4 and GPT-4o models.',
'https://chat.openai.com',
NULL),

-- 3. Gemini (Google)
('Gemini', 'gemini',
'Google''s multimodal AI model with strong performance in reasoning, coding, and multimodal tasks. Previously known as Bard.',
'https://gemini.google.com',
NULL),

-- 4. Grok (xAI)
('Grok', 'grok',
'AI assistant by xAI with real-time information access and humorous personality. Integrated with X (Twitter) platform.',
'https://grok.x.ai',
NULL),

-- 5. DeepSeek
('DeepSeek', 'deepseek',
'Advanced AI model with strong coding and reasoning capabilities. Open-source alternative with competitive performance.',
'https://deepseek.com',
NULL),

-- 6. GitHub Copilot
('GitHub Copilot', 'github-copilot',
'AI pair programmer powered by OpenAI Codex. Provides code suggestions directly in your IDE with deep GitHub integration.',
'https://github.com/features/copilot',
NULL),

-- 7. Cursor AI
('Cursor', 'cursor',
'AI-powered code editor built from the ground up for AI pair programming. Features include multi-file editing and codebase understanding.',
'https://cursor.sh',
NULL),

-- 8. Windsurf (Codeium)
('Windsurf', 'windsurf',
'AI-powered IDE by Codeium with agentic coding capabilities. Features Cascade for multi-file edits and deep codebase understanding.',
'https://codeium.com/windsurf',
NULL),

-- 9. Augment Code
('Augment', 'augment',
'AI coding assistant with superior context engine that understands entire codebases. Features real-time indexing up to 500K files.',
'https://augmentcode.com',
NULL),

-- 10. Tabnine
('Tabnine', 'tabnine',
'AI code completion tool that learns from your code patterns. Offers both cloud and on-premise deployment options for enterprises.',
'https://tabnine.com',
NULL),

-- 11. Amazon Q Developer
('Amazon Q Developer', 'amazon-q',
'Amazon''s AI-powered coding assistant integrated with AWS services. Features include code transformation and security scanning.',
'https://aws.amazon.com/q/developer',
NULL),

-- 12. Replit AI
('Replit AI', 'replit',
'AI coding assistant built into Replit online IDE. Features include code generation, debugging, and deployment automation.',
'https://replit.com/ai',
NULL),

-- 13. Sourcegraph Cody
('Cody', 'cody',
'AI coding assistant by Sourcegraph with deep code search capabilities. Understands your entire codebase and dependencies.',
'https://sourcegraph.com/cody',
NULL),

-- 14. Continue
('Continue', 'continue',
'Open-source AI coding assistant that works with any LLM. Supports local models and custom configurations for maximum flexibility.',
'https://continue.dev',
NULL),

-- 15. Supermaven
('Supermaven', 'supermaven',
'Fast AI code completion with 300K+ token context window. Created by the original author of GitHub Copilot.',
'https://supermaven.com',
NULL)

ON CONFLICT (slug) DO NOTHING;

-- ============================================
-- VERIFICATION
-- ============================================

-- Count inserted tools (should be 15)
DO $$
DECLARE
  tool_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO tool_count FROM ai_tools;

  IF tool_count = 15 THEN
    RAISE NOTICE 'Success! Inserted 15 AI tools.';
  ELSE
    RAISE NOTICE 'Warning: Expected 15 tools, found %', tool_count;
  END IF;
END $$;

-- Display all inserted tools
SELECT
  name,
  slug,
  official_url,
  created_at
FROM ai_tools
ORDER BY name;

-- ============================================
-- SEED COMPLETE
-- ============================================
-- Next step: Add sample feature updates (Task 3.7)
-- ============================================
