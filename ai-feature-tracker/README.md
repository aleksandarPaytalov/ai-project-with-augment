# AI Feature Tracker - MVP

A simple, beautiful dashboard that displays 15 AI development tools with their latest feature updates. Built with Next.js 14+, TypeScript, Supabase, and OpenAI API.

## Overview

AI Feature Tracker is a public information platform for developers and AI enthusiasts who need to stay current with AI development tools. The application tracks feature updates across 15 popular AI code assistants including Claude, ChatGPT, Gemini, Grok, DeepSeek, GitHub Copilot, Cursor AI, Windsurf, and Augment.

### Key Features

- 📊 Single-page dashboard displaying all 15 AI tools
- 🔄 Daily automated checks for new features via OpenAI API
- ⚡ Real-time updates using Supabase subscriptions (optional)
- 📱 Fully responsive design (mobile, tablet, desktop)
- 🎨 Beautiful UI with Tailwind CSS

## Tech Stack

- **Frontend**: Next.js 14+ with App Router, TypeScript, Tailwind CSS
- **Database**: Supabase (PostgreSQL)
- **AI Integration**: OpenAI API (GPT-4o-mini)
- **Real-time**: Supabase Real-time subscriptions
- **Deployment**: Vercel
- **AI Assistant**: Augment Code for development workflow

## Project Structure

```
ai-project-with-augment/
├── .augment/
│   └── rules/                    # Augment Code manual rules (workspace level)
│       ├── README.md             # Rules system documentation
│       └── app-rules/            # Step-specific development rules
│           └── step-*.md
├── ai-feature-tracker/           # Main Next.js project
│   ├── app/
│   │   ├── api/
│   │   │   └── tools/
│   │   │       └── route.ts      # API endpoint for tools
│   │   ├── layout.tsx            # Root layout component
│   │   └── page.tsx              # Homepage (dashboard)
│   ├── components/
│   │   ├── ui/                   # Reusable UI components
│   │   │   ├── Button.tsx        # Button component
│   │   │   ├── Card.tsx          # Card wrapper component
│   │   │   └── LoadingSpinner.tsx # Loading spinner
│   │   ├── ToolCard.tsx          # Tool display card component
│   │   └── ToolsGrid.tsx         # Grid layout component
│   ├── lib/
│   │   ├── supabase/
│   │   │   └── client.ts         # Supabase client initialization
│   │   └── utils/
│   │       ├── date.ts           # Date formatting utilities
│   │       └── sort.ts           # Sorting logic utilities
│   ├── types/
│   │   ├── index.ts              # Application type definitions
│   │   └── supabase.ts           # Auto-generated database types
│   ├── public/
│   │   └── logos/                # AI tool logo images
│   │       └── README.md         # Logo requirements and naming
│   ├── .env.local                # Environment variables (not in repo)
│   ├── .env.example              # Environment variables template
│   ├── .gitignore                # Git ignore rules
│   ├── next.config.ts            # Next.js configuration
│   ├── package.json              # Project dependencies
│   ├── tsconfig.json             # TypeScript configuration
│   └── README.md                 # This file
└── info.txt                      # Workspace information
```

## Directory Purpose

### `.augment/rules/` (Workspace Level)

Contains Manual-type rules for Augment Code agent. Each rule is focused on a specific development task to maintain control and prevent scope creep during AI-assisted development. Located at the workspace level to manage multiple projects.

### `app/`

Next.js 14+ App Router directory. Contains pages, layouts, and API routes following the file-system based routing convention.

- **`app/page.tsx`**: Main dashboard page displaying all tools
- **`app/layout.tsx`**: Root layout wrapping all pages
- **`app/api/tools/route.ts`**: REST API endpoint for fetching tools with their latest features

### `components/`

React components organized by purpose. Reusable UI components are in the `ui/` subdirectory.

- **`ToolCard.tsx`**: Displays a single AI tool with its latest feature update
- **`ToolsGrid.tsx`**: Responsive grid layout for tool cards
- **`ui/`**: Shared UI components (buttons, cards, spinners)

### `lib/`

Utility functions, database clients, and helper modules.

- **`lib/supabase/client.ts`**: Supabase client for database operations
- **`lib/utils/date.ts`**: Date formatting functions
- **`lib/utils/sort.ts`**: Tool sorting logic (by date, alphabetically)

### `types/`

TypeScript type definitions for the entire application.

- **`types/index.ts`**: Core application types (Tool, FeatureUpdate, etc.)
- **`types/supabase.ts`**: Auto-generated types from Supabase schema

> **⚠️ Important:** `types/supabase.ts` should **never be manually edited**. This file is auto-generated from your Supabase database schema. To regenerate it whenever the database schema changes, use:
>
> ```bash
> npm run types:generate
> ```

### `public/logos/`

Static assets served directly. Contains logo images for all 15 AI tools.

## TypeScript Types System

The project uses a comprehensive TypeScript type system for type safety and better developer experience.

### Type Files

- **`types/supabase.ts`**: Auto-generated types from Supabase database schema

  - Generated using: `npm run types:generate`
  - Never edit this file manually
  - Regenerate after database schema changes

- **`types/index.ts`**: Application-level types
  - Clean, easy-to-use types for components and business logic
  - Includes composite types for joined data
  - Type guards for runtime type checking

### Key Types

```typescript
import {
  Tool, // AI tool from database
  FeatureUpdate, // Feature announcement
  ToolWithLatestFeature, // Tool + latest feature (for dashboard)
  SortOption, // 'date' | 'alphabetical'
  ApiResponse, // Standard API response format
} from "@/types";
```

### Type Generation

Regenerate database types after schema changes:

```bash

# Generate types from remote Supabase database

npm run types:generate

# Or manually

npx supabase gen types typescript --project-id your-project-id > types/supabase.ts
```

### Documentation

- **Type Guide**: `docs/typescript-types-guide.md` - Comprehensive usage examples
- **CLI Commands**: `docs/supabase-cli-commands.md` - Supabase CLI reference

### Best Practices

1. **Always use types** for function parameters and return values
2. **Use type guards** (`isApiError`, `hasLatestFeature`) for runtime checks
3. **Import from `@/types`** not from `types/supabase` directly
4. **Regenerate types** after any database schema changes

## Development Workflow

This project uses **Augment Code** with Manual rules for controlled, step-by-step development:

1. Reference a specific rule: `@step-02-task-01`
2. Complete the task following the checklist
3. Verify all checklist items are done
4. Move to next task: `@step-02-task-02`

See `../.augment/rules/README.md` for detailed workflow documentation.

## Getting Started

### Prerequisites

- Node.js 18+ and npm/yarn
- Supabase account
- OpenAI API key (for automated updates)

### Installation

```bash
# Clone the repository
git clone https://github.com/aleksandarPaytalov/ai-project-with-augment.git
cd ai-project-with-augment/ai-feature-tracker

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env.local

# Edit .env.local with your Supabase and OpenAI credentials

# Run development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the app.

## Environment Variables

Required environment variables (see `.env.example`):

```bash
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
OPENAI_API_KEY=your_openai_api_key
CRON_SECRET=your_random_secret_string
```

## MVP Development Phases

- **Phase 1**: Foundation (Setup, folder structure) ✅
- **Phase 2**: Database (Schema, types, client)
- **Phase 3**: API (Routes, data fetching)
- **Phase 4**: UI (Components, dashboard)
- **Phase 5**: Polish & Deploy

## Contributing

This is a personal MVP project. Contributions are welcome after the initial release.

## License

MIT License - see LICENSE file for details.

## Contact

Aleksandar Paytalov - [apaytalov89@gmail.com]

Project Link: [https://github.com/aleksandarPaytalov/ai-project-with-augment](https://github.com/aleksandarPaytalov/ai-project-with-augment)
