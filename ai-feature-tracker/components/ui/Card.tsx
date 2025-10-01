/**
 * Reusable card wrapper component providing consistent card styling.
 * Used as base component for ToolCard and other card-based layouts.
 * Will be styled with Tailwind CSS in Step 10.
 */
import React from "react";

interface CardProps {
  children: React.ReactNode;
}

const Card: React.FC<CardProps> = ({ children }) => {
  return <div>{children}</div>;
};

export default Card;
