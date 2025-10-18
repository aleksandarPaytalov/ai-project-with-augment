/**
 * Type tests for AI Feature Tracker application.
 *
 * This file tests that all types compile correctly and can be used
 * as intended throughout the application.
 *
 * Run with: npx tsc --noEmit types/__tests__/types.test.ts
 */

import {
  // Basic types
  Tool,
  FeatureUpdate,
  InsertTool,
  InsertFeatureUpdate,
  UpdateTool,
  UpdateFeatureUpdate,

  // Composite types
  ToolWithLatestFeature,
  ToolCardData,
  FeatureCardData,
  ToolCardDisplayData,

  // UI state types
  SortOption,
  LoadingState,
  DashboardState,

  // API types
  ApiSuccessResponse,
  ApiErrorResponse,
  ApiResponse,

  // Utility types
  RequireFields,
  OptionalFields,

  // Type guards
  isApiError,
  hasLatestFeature,

  // Database type
  Database,
} from "../index";

// ============================================
// TEST 1: Basic Database Types
// ============================================

const testTool: Tool = {
  id: "550e8400-e29b-41d4-a716-446655440000",
  name: "Claude",
  slug: "claude",
  description: "AI assistant by Anthropic",
  official_url: "https://claude.ai",
  logo_url: "/logos/claude.png",
  last_checked_at: null,
  created_at: "2024-01-15T10:00:00Z",
  updated_at: "2024-01-15T10:00:00Z",
};

const testFeature: FeatureUpdate = {
  id: "660e8400-e29b-41d4-a716-446655440001",
  tool_id: testTool.id,
  title: "Claude 4 Released",
  description: "Major update with improved reasoning capabilities",
  official_url: "https://anthropic.com/claude-4",
  published_at: "2024-01-15T09:00:00Z",
  created_at: "2024-01-15T10:00:00Z",
};

// ============================================
// TEST 2: Insert and Update Types
// ============================================

const newTool: InsertTool = {
  name: "New AI Tool",
  slug: "new-ai-tool",
  official_url: "https://example.com",
  // Optional fields can be omitted
};

const updateTool: UpdateTool = {
  description: "Updated description",
  // All other fields are optional
};

// ============================================
// TEST 3: Composite Types
// ============================================

const toolWithFeature: ToolWithLatestFeature = {
  ...testTool,
  latestFeature: testFeature,
};

const toolWithoutFeature: ToolWithLatestFeature = {
  ...testTool,
  latestFeature: null,
};

// ============================================
// TEST 4: UI State Types
// ============================================

const sortByDate: SortOption = "date";
const sortAlphabetically: SortOption = "alphabetical";

const loadingState: LoadingState = "loading";

const dashboardState: DashboardState = {
  tools: [toolWithFeature, toolWithoutFeature],
  sortOption: sortByDate,
  loadingState: loadingState,
  error: null,
};

// ============================================
// TEST 5: API Response Types
// ============================================

const successResponse: ApiSuccessResponse<Tool[]> = {
  success: true,
  data: [testTool],
  message: "Tools fetched successfully",
};

const errorResponse: ApiErrorResponse = {
  success: false,
  error: "Failed to fetch tools",
  code: "DATABASE_ERROR",
  details: { reason: "Connection timeout" },
};

// ============================================
// TEST 6: Type Guards
// ============================================

// Test isApiError with error response
if (isApiError(errorResponse)) {
  const errorMessage: string = errorResponse.error;
  const errorCode: string | undefined = errorResponse.code;
}

// Test isApiError with success response (should be false)
if (!isApiError(successResponse)) {
  const data: Tool[] = successResponse.data;
}

// Test hasLatestFeature with feature present
if (hasLatestFeature(toolWithFeature)) {
  const featureTitle: string = toolWithFeature.latestFeature.title;
}

// Test hasLatestFeature with null feature - should return false
const hasFeatureResult: boolean = hasLatestFeature(toolWithoutFeature);
if (hasFeatureResult === false) {
  // This tool has no latest feature
  console.log("Tool without feature correctly identified");
}

console.log("✅ All type tests passed successfully!");
console.log(
  "Types are correctly defined and can be used throughout the application."
);
