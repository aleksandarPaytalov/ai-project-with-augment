# AI Feature Tracker - Database Schema Design

## Overview

Simple two-table relational database design for storing AI development tools and their feature updates.

## Entity Relationship Diagram

```
┌─────────────────────────────────┐
│ ai_tools                        │
├─────────────────────────────────┤
│ id (PK) UUID                    │
│ name VARCHAR                    │
│ slug VARCHAR                    │
│ description TEXT                │
│ official_url VARCHAR            │
│ logo_url VARCHAR                │
│ last_checked_at TIMESTAMP       │
│ created_at TIMESTAMP            │
│ updated_at TIMESTAMP            │
└─────────────────────────────────┘
                │
                │ 1
                │
                │
                │ *
┌─────────────────────────────────┐
│ feature_updates                 │
├─────────────────────────────────┤
│ id (PK) UUID                    │
│ tool_id (FK) UUID ──→ ai_tools.id
│ title VARCHAR                   │
│ description TEXT                │
│ official_url VARCHAR            │
│ published_at TIMESTAMP          │
│ created_at TIMESTAMP            │
└─────────────────────────────────┘
```

## Table Specifications

### Table: `ai_tools`

Stores information about each AI development tool.

| Column            | Type                     | Constraints                            | Description                        |
| ----------------- | ------------------------ | -------------------------------------- | ---------------------------------- |
| `id`              | UUID                     | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier                  |
| `name`            | VARCHAR(255)             | NOT NULL, UNIQUE                       | Tool name (e.g., "Claude")         |
| `slug`            | VARCHAR(255)             | NOT NULL, UNIQUE                       | URL-friendly name (e.g., "claude") |
| `description`     | TEXT                     | NULLABLE                               | Brief tool description             |
| `official_url`    | VARCHAR(255)             | NOT NULL                               | Official website URL               |
| `logo_url`        | VARCHAR(255)             | NULLABLE                               | Path to logo image                 |
| `last_checked_at` | TIMESTAMP WITH TIME ZONE | NULLABLE                               | Last automated check timestamp     |
| `created_at`      | TIMESTAMP WITH TIME ZONE | NOT NULL, DEFAULT NOW()                | Record creation timestamp          |
| `updated_at`      | TIMESTAMP WITH TIME ZONE | NOT NULL, DEFAULT NOW()                | Record update timestamp            |

**Indexes:**

- Primary Key index on `id` (automatic)
- Unique index on `slug` (for URL routing)
- Unique index on `name` (prevent duplicates)

**Business Rules:**

- `slug` must be unique and lowercase with hyphens
- `name` must be unique across all tools
- `official_url` must be a valid URL format

### Table: `feature_updates`

Stores feature announcements and updates for each tool.

| Column         | Type                     | Constraints                                            | Description                  |
| -------------- | ------------------------ | ------------------------------------------------------ | ---------------------------- |
| `id`           | UUID                     | PRIMARY KEY, DEFAULT gen_random_uuid()                 | Unique identifier            |
| `tool_id`      | UUID                     | NOT NULL, FOREIGN KEY → ai_tools(id) ON DELETE CASCADE | Reference to parent tool     |
| `title`        | VARCHAR(500)             | NOT NULL                                               | Feature update title         |
| `description`  | TEXT                     | NOT NULL                                               | Detailed feature description |
| `official_url` | VARCHAR(500)             | NULLABLE                                               | Link to announcement source  |
| `published_at` | TIMESTAMP WITH TIME ZONE | NOT NULL, DEFAULT NOW()                                | Feature publication date     |
| `created_at`   | TIMESTAMP WITH TIME ZONE | NOT NULL, DEFAULT NOW()                                | Record creation timestamp    |

**Indexes:**

- Primary Key index on `id` (automatic)
- Foreign Key index on `tool_id` (for joins)
- Index on `published_at` DESC (for sorting by date)
- Composite index on `(tool_id, published_at DESC)` (for latest feature queries)

**Business Rules:**

- `tool_id` must reference a valid tool in `ai_tools` table
- ON DELETE CASCADE: Deleting a tool deletes all its features
- `published_at` defaults to NOW() but can be set to actual announcement date

## Design Decisions

### Why UUID instead of SERIAL?

- UUIDs are globally unique (safe for distributed systems)
- No sequential ID leakage (security)
- Compatible with Supabase best practices

### Why TEXT for descriptions?

- No arbitrary length limits
- PostgreSQL handles TEXT efficiently
- Future-proof for long feature descriptions

### Why TIMESTAMP WITH TIME ZONE?

- Handles international users correctly
- Stores UTC time internally
- Converts to user's timezone on display

### Why ON DELETE CASCADE?

- Tools and features are tightly coupled
- Orphaned features have no meaning without parent tool
- Simplifies cleanup operations

### Why separate last_checked_at from updated_at?

- `last_checked_at` tracks automated checks (can be null initially)
- `updated_at` tracks any record modification
- Different business meanings
