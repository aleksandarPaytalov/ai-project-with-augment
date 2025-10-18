/**
 * Central type definitions for the AI Feature Tracker application.
 * Contains core data models for tools, features, and application state.
 *
 * These types are based on the Supabase database schema but simplified
 * for easier use throughout the application.
 */

import { Database } from "./supabase";

// ============================================
// DATABASE TABLE TYPES (Extracted from Supabase)
// ============================================

/**
 * AI Tool record from database.
 * Represents a single AI development tool tracked in the application.
 */
export type Tool = Database["public"]["Tables"]["ai_tools"]["Row"];

/**
 * Feature Update record from database.
 * Represents a feature announcement or update for an AI tool.
 */
export type FeatureUpdate =
  Database["public"]["Tables"]["feature_updates"]["Row"];

/**
 * Insert type for creating a new AI tool.
 * Used when adding new tools to the database.
 */
export type InsertTool = Database["public"]["Tables"]["ai_tools"]["Insert"];

/**
 * Insert type for creating a new feature update.
 * Used when adding new features to the database.
 */
export type InsertFeatureUpdate =
  Database["public"]["Tables"]["feature_updates"]["Insert"];

/**
 * Update type for modifying an existing AI tool.
 * All fields are optional - update only what changed.
 */
export type UpdateTool = Database["public"]["Tables"]["ai_tools"]["Update"];

/**
 * Update type for modifying an existing feature update.
 * All fields are optional - update only what changed.
 */
export type UpdateFeatureUpdate =
  Database["public"]["Tables"]["feature_updates"]["Update"];

// ============================================
// COMPOSITE TYPES (For Joined Queries)
// ============================================

/**
 * Tool with its latest feature update attached.
 *
 * This is the primary type used on the dashboard, representing
 * a tool along with its most recent feature announcement.
 *
 * @example
 * const toolWithFeature: ToolWithLatestFeature = {
 *   id: '123',
 *   name: 'Claude',
 *   slug: 'claude',
 *   // ... other tool fields
 *   latestFeature: {
 *     id: '456',
 *     title: 'Claude 4 Released',
 *     description: 'New features...',
 *     // ... other feature fields
 *   }
 * };
 */
export interface ToolWithLatestFeature extends Tool {
  latestFeature: FeatureUpdate | null;
}

/**
 * Simplified tool data for display purposes.
 * Contains only the essential fields needed for the dashboard cards.
 */
export interface ToolCardData {
  id: string;
  name: string;
  slug: string;
  logo_url: string | null;
  official_url: string;
}

/**
 * Simplified feature data for display purposes.
 * Contains only the essential fields needed for feature cards.
 */
export interface FeatureCardData {
  id: string;
  title: string;
  description: string;
  official_url: string | null;
  published_at: string;
}

/**
 * Combined data for tool card display.
 * Optimized for the dashboard's tool card component.
 */
export interface ToolCardDisplayData extends ToolCardData {
  latestFeature: FeatureCardData | null;
}

// ============================================
// UI STATE TYPES
// ============================================

/**
 * Sorting options for the tools dashboard.
 *
 * - 'date': Sort by latest feature update (newest first)
 * - 'alphabetical': Sort by tool name (A-Z)
 */
export type SortOption = "date" | "alphabetical";

/**
 * Loading states for async operations.
 */
export type LoadingState = "idle" | "loading" | "success" | "error";

/**
 * Dashboard view state.
 * Tracks the current state of the dashboard UI.
 */
export interface DashboardState {
  tools: ToolWithLatestFeature[];
  sortOption: SortOption;
  loadingState: LoadingState;
  error: string | null;
}

// ============================================
// API RESPONSE TYPES
// ============================================

/**
 * Standard API success response.
 * Used for all successful API responses.
 */
export interface ApiSuccessResponse<T> {
  success: true;
  data: T;
  message?: string;
}

/**
 * Standard API error response.
 * Used for all error responses from API routes.
 */
export interface ApiErrorResponse {
  success: false;
  error: string;
  code?: string;
  details?: unknown;
}

/**
 * Union type for API responses.
 * All API routes should return this type.
 */
export type ApiResponse<T> = ApiSuccessResponse<T> | ApiErrorResponse;

// ============================================
// UTILITY TYPES
// ============================================

/**
 * Makes specified keys required in a type.
 *
 * @example
 * type ToolWithRequiredLogo = RequireFields<Tool, 'logo_url'>;
 */
export type RequireFields<T, K extends keyof T> = T & Required<Pick<T, K>>;

/**
 * Makes specified keys optional in a type.
 *
 * @example
 * type PartialTool = OptionalFields<Tool, 'description' | 'logo_url'>;
 */
export type OptionalFields<T, K extends keyof T> = Omit<T, K> &
  Partial<Pick<T, K>>;

// ============================================
// TYPE GUARDS
// ============================================

/**
 * Type guard to check if a response is an error.
 *
 * @example
 * const response = await fetch('/api/tools');
 * if (isApiError(response)) {
 *   console.error(response.error);
 * }
 */
export function isApiError(response: unknown): response is ApiErrorResponse {
  return (
    typeof response === "object" &&
    response !== null &&
    "success" in response &&
    response.success === false
  );
}

/**
 * Type guard to check if a tool has a latest feature.
 *
 * @example
 * if (hasLatestFeature(tool)) {
 *   console.log(tool.latestFeature.title); // TypeScript knows it's not null
 * }
 */
export function hasLatestFeature(
  tool: ToolWithLatestFeature
): tool is ToolWithLatestFeature & { latestFeature: FeatureUpdate } {
  return tool.latestFeature !== null;
}

// ============================================
// EXPORTS FOR CONVENIENCE
// ============================================

/**
 * Re-export the Database type for direct Supabase client usage.
 * Use this when you need to interact directly with Supabase types.
 */
export type { Database } from "./supabase";
