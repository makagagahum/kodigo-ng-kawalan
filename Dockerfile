# Multi-stage build: Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Copy root package files
COPY package*.json ./

# Copy orin-revamp directory with its package files
COPY orin-revamp/package*.json ./orin-revamp/

# Install all dependencies (including devDependencies for build)
RUN npm ci
RUN cd orin-revamp && npm ci

# Copy all source files
COPY . .

# Build the React app
RUN npm run build

# Production stage
FROM node:20-alpine
WORKDIR /app

# Copy package files from builder
COPY package*.json ./

# Install only production dependencies for runtime
RUN npm ci --only=production && npm cache clean --force

# Copy built files from builder
COPY --from=builder /app/orin-revamp/dist ./orin-revamp/dist
COPY --from=builder /app/server.js ./

# Copy environment example (optional, for reference)
COPY .env.example ./

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})" || exit 1

CMD ["npm", "start"]
