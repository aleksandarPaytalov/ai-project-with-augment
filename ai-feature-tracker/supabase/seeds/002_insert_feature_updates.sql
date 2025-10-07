-- ============================================
-- AI Feature Tracker - Seed Feature Updates
-- ============================================
-- Description: Insert sample feature updates for all 15 AI tools
-- Created: 2024-01-15
-- Author: Aleksandar Paytalov
--
-- This seed file inserts 1-2 sample feature updates per tool
-- to provide initial dashboard content for testing and demo.
-- ============================================

-- ============================================
-- INSERT FEATURE UPDATES
-- ============================================

INSERT INTO feature_updates (tool_id, title, description, official_url, published_at) VALUES

-- 1. Claude - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'claude'),
'Claude 4 Released with Extended Context',
'Anthropic announces Claude 4 with improved reasoning capabilities, extended context window up to 200K tokens, and enhanced code generation. The model shows significant improvements in complex problem-solving and maintains better consistency across long conversations.',
'https://anthropic.com/news/claude-4',
NOW() - INTERVAL '5 days'),

((SELECT id FROM ai_tools WHERE slug = 'claude'),
'New Projects Feature in Claude.ai',
'Claude.ai now supports Projects, allowing users to organize conversations with custom knowledge bases and instructions. Projects can include up to 100 documents and maintain context across multiple chat sessions.',
'https://anthropic.com/news/projects',
NOW() - INTERVAL '12 days'),

-- 2. ChatGPT - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'chatgpt'),
'GPT-4o with Vision Capabilities',
'OpenAI releases GPT-4o with enhanced multimodal capabilities including image understanding, faster response times, and improved coding abilities. The model is now available to all ChatGPT Plus subscribers.',
'https://openai.com/blog/gpt-4o',
NOW() - INTERVAL '3 days'),

((SELECT id FROM ai_tools WHERE slug = 'chatgpt'),
'ChatGPT Memory Feature Now Available',
'ChatGPT can now remember information across conversations, learning your preferences and context over time. Users have full control over what ChatGPT remembers and can clear memory at any time.',
'https://openai.com/blog/memory-chatgpt',
NOW() - INTERVAL '8 days'),

-- 3. Gemini - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'gemini'),
'Gemini 2.0 Flash Released',
'Google announces Gemini 2.0 Flash, their fastest and most efficient model yet. Features improved reasoning, better code generation, and native multimodal capabilities.',
'https://blog.google/technology/ai/gemini-2-flash',
NOW() - INTERVAL '2 days'),

-- 4. Grok - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'grok'),
'Grok 2 with Real-Time Information',
'xAI releases Grok 2 with enhanced real-time information access from X platform. The model provides up-to-the-minute information and improved reasoning capabilities.',
'https://x.ai/blog/grok-2',
NOW() - INTERVAL '7 days'),

-- 5. DeepSeek - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'deepseek'),
'DeepSeek-V3 Open Source Release',
'DeepSeek releases V3 model with competitive performance to GPT-4 at a fraction of the cost. The model is fully open-source with strong coding and reasoning capabilities.',
'https://deepseek.com/blog/v3-release',
NOW() - INTERVAL '4 days'),

-- 6. GitHub Copilot - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'github-copilot'),
'Copilot Chat in IDE',
'GitHub Copilot now includes an inline chat feature directly in your IDE. Ask questions, generate code, and get explanations without leaving your editor.',
'https://github.blog/copilot-chat',
NOW() - INTERVAL '10 days'),

((SELECT id FROM ai_tools WHERE slug = 'github-copilot'),
'Multi-File Editing Support',
'GitHub Copilot adds multi-file editing capabilities, allowing the AI to make coordinated changes across multiple files in your project simultaneously.',
'https://github.blog/multi-file-editing',
NOW() - INTERVAL '15 days'),

-- 7. Cursor - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'cursor'),
'Composer Mode for Large Changes',
'Cursor introduces Composer mode for making sweeping changes across your entire codebase. The AI can now handle complex refactoring tasks spanning dozens of files.',
'https://cursor.sh/blog/composer',
NOW() - INTERVAL '6 days'),

-- 8. Windsurf - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'windsurf'),
'Cascade 2.0 with Enhanced Context',
'Windsurf releases Cascade 2.0 with dramatically improved codebase understanding. The AI can now reference and edit files across your entire project with better accuracy.',
'https://codeium.com/blog/windsurf-cascade-2',
NOW() - INTERVAL '9 days'),

-- 9. Augment - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'augment'),
'Real-Time Codebase Indexing',
'Augment introduces real-time indexing that updates within seconds of code changes. The context engine now supports up to 500K files with 200K token context windows.',
'https://augmentcode.com/blog/real-time-indexing',
NOW() - INTERVAL '11 days'),

-- 10. Tabnine - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'tabnine'),
'Enterprise On-Premise Deployment',
'Tabnine expands enterprise offerings with fully on-premise deployment options. Companies can now run Tabnine entirely within their own infrastructure for maximum security.',
'https://tabnine.com/blog/enterprise-on-premise',
NOW() - INTERVAL '14 days'),

-- 11. Amazon Q Developer - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'amazon-q'),
'AWS Integration and Code Transformation',
'Amazon Q Developer adds deep AWS service integration and automated code transformation capabilities. Modernize legacy applications with AI-powered refactoring.',
'https://aws.amazon.com/blogs/aws/amazon-q-updates',
NOW() - INTERVAL '13 days'),

-- 12. Replit AI - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'replit'),
'AI-Powered Deployment Automation',
'Replit AI now handles complete deployment workflows automatically. From code generation to production deployment, all powered by AI.',
'https://blog.replit.com/ai-deployment',
NOW() - INTERVAL '16 days'),

-- 13. Cody - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'cody'),
'Deep Code Search Integration',
'Sourcegraph Cody now includes deep code search across your entire organization. Search through documentation, repos, and dependencies seamlessly.',
'https://sourcegraph.com/blog/cody-code-search',
NOW() - INTERVAL '18 days'),

-- 14. Continue - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'continue'),
'Support for Local LLMs',
'Continue adds comprehensive support for running local LLMs including Llama, Mistral, and CodeLlama. Keep your code completely private with on-device AI.',
'https://continue.dev/blog/local-llms',
NOW() - INTERVAL '20 days'),

-- 15. Supermaven - Feature Updates
((SELECT id FROM ai_tools WHERE slug = 'supermaven'),
'300K Token Context Window',
'Supermaven introduces industry-leading 300K token context window, allowing the AI to understand massive codebases. Built by the original creator of GitHub Copilot.',
'https://supermaven.com/blog/300k-context',
NOW() - INTERVAL '25 days');

-- ============================================
-- VERIFICATION
-- ============================================

-- Count inserted feature updates
DO $$
DECLARE
  feature_count INTEGER;
  tools_with_features INTEGER;
BEGIN
  SELECT COUNT(*) INTO feature_count FROM feature_updates;
  SELECT COUNT(DISTINCT tool_id) INTO tools_with_features FROM feature_updates;

  RAISE NOTICE 'Inserted % feature updates', feature_count;
  RAISE NOTICE '% tools have at least one feature', tools_with_features;

  IF tools_with_features = 15 THEN
    RAISE NOTICE 'Success! All 15 tools have feature updates.';
  ELSE
    RAISE NOTICE 'Warning: Only % out of 15 tools have features', tools_with_features;
  END IF;
END $$;

-- Display feature updates per tool
SELECT
  t.name AS tool_name,
  COUNT(f.id) AS feature_count,
  MAX(f.published_at) AS latest_feature_date
FROM ai_tools t
LEFT JOIN feature_updates f ON t.id = f.tool_id
GROUP BY t.name
ORDER BY MAX(f.published_at) DESC NULLS LAST;

-- Show most recent features across all tools
SELECT
  t.name AS tool_name,
  f.title AS feature_title,
  f.published_at,
  EXTRACT(DAY FROM NOW() - f.published_at) || ' days ago' AS recency
FROM feature_updates f
JOIN ai_tools t ON f.tool_id = t.id
ORDER BY f.published_at DESC
LIMIT 10;

-- ============================================
-- SEED COMPLETE
-- ============================================
-- Database is now ready with:
-- - 15 AI tools
-- - 16 feature updates (1-2 per tool)
-- - All tables, indexes, and constraints
--
-- Next step: Generate TypeScript types (Step 4)
-- ============================================
