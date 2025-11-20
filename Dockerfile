# Multi-stage build: Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Copy root package files
COPY package*.json ./

# Copy orin-revamp directory with its package files
COPY orin-revamp/package*.json ./orin-revamp/

# Install all dependencies (including devDependencies for build)
RUN npm install
RUN cd orin-revamp && npm install
# Copy all source files
COPY . .

# Build the React app
# RUN npm run build - React source files not in repo, skipping build

# Production stage
FROM node:20-alpine
WORKDIR /app

# Copy package files from builder
COPY package*.json ./

# Install only production dependencies for runtime
RUN npm install --production
# Copy server.js and other source files from repo root
COPY server.js .
# COPY index.html . - legacy file, skipped
# Copy built React app from builder
# COPY --from=builder /app/orin-revamp/dist ./orin-revamp/dist - skipped, React not built

# Expose port for Render
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
