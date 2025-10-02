/**
 * Central type definitions for the AI Feature Tracker application.
 * Contains core data models for tools, features, and application state.
 * Will be fully defined in Step 4 after database schema is created.
 */

/**
 * Represents an AI development tool
 */
export interface Tool {
  id: string;
  name: string;
  slug: string;
  official_url: string;
  logo_url: string | null;
  last_checked_at: string | null;
  created_at: string;
  updated_at: string;
}

/**
 * Represents a feature update for a tool
 */
export interface FeatureUpdate {
  id: string;
  tool_id: string;
  title: string;
  description: string;
  official_url: string | null;
  published_at: string;
  created_at: string;
}

/**
 * Tool with its latest feature update joined
 */
export interface ToolWithLatestFeature extends Tool {
  latestFeature: FeatureUpdate | null;
}

/**
 * Sorting options for the tool dashboard
 */
export type SortOption = "date" | "alphabetical";
