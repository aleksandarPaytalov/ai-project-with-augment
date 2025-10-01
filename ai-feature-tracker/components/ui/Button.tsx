/**
 * Reusable button component with consistent styling across the application.
 * Supports different variants and sizes for various use cases.
 * Will be styled with Tailwind CSS in Step 10.
 */
import React from "react";

interface ButtonProps {
  children: React.ReactNode;
  onClick?: () => void;
}

const Button: React.FC<ButtonProps> = ({ children, onClick }) => {
  return <button onClick={onClick}>{children}</button>;
};

export default Button;
