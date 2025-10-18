/**
 * Tool card component displaying a single AI tool with its latest feature update.
 * Renders tool name, logo, feature description, and last updated timestamp.
 * Will be fully implemented in Step 7.
 */
import React from "react";
import { ToolWithLatestFeature } from "@/types";

interface ToolCardProps {
  tool: ToolWithLatestFeature;
  onToolClick?: (toolId: string) => void;
}

const ToolCard: React.FC<ToolCardProps> = ({ tool, onToolClick }) => {
  return (
    <div>
      {/* ToolCard - Step 7 */}
      <p>Tool: {tool.name}</p>
    </div>
  );
};

export default ToolCard;
