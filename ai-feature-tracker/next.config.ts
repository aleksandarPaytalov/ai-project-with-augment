import type { NextConfig } from "next";
import path from "path";

const nextConfig: NextConfig = {
  // Fix Next.js workspace root detection warning
  outputFileTracingRoot: path.join(__dirname),

  // Other config options here
};

export default nextConfig;
