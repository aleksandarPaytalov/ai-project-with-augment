# AI Tool Logos

This directory contains logo images for the 15 AI development tools featured in the AI Feature Tracker.

## File Naming Convention

Logo files should follow this naming pattern:

- **Format**: `{tool-slug}.png` or `{tool-slug}.svg`
- **Example**: `claude.png`, `chatgpt.svg`, `github-copilot.png`

The `tool-slug` must match the `slug` field in the database exactly.

## Image Requirements

- **Format**: PNG or SVG preferred
- **Size**: Recommended 256x256px (will be resized to 64x64px in UI)
- **Background**: Transparent or white background
- **Quality**: High resolution for crisp display

## Expected Logo Files

The following 15 logo files will be added in future steps:

1. `claude.png` - Claude (Anthropic)
2. `chatgpt.png` - ChatGPT (OpenAI)
3. `gemini.png` - Gemini (Google)
4. `grok.png` - Grok (xAI)
5. `deepseek.png` - DeepSeek
6. `github-copilot.png` - GitHub Copilot
7. `cursor.png` - Cursor AI
8. `windsurf.png` - Windsurf (Codeium)
9. `augment.png` - Augment Code
10. `tabnine.png` - Tabnine
11. `amazon-q.png` - Amazon Q Developer
12. `replit.png` - Replit AI
13. `cody.png` - Sourcegraph Cody
14. `continue.png` - Continue
15. `supermaven.png` - Supermaven

## Placeholder

If a logo is missing, the UI will display a placeholder or the first letter of the tool name.

## Usage in Code

```typescript
// Accessing logo in Next.js Image component
<Image
  src={`/logos/${tool.slug}.png`}
  alt={`${tool.name} logo`}
  width={64}
  height={64}
/>
```

## Notes

- Logos are served statically from the `/public` directory
- No need to import logos - they're accessible via URL path
- Logos will be added manually or sourced from official tool websites
