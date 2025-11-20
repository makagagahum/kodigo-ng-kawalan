# Multi-stage build: Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Copy root package files
COPY package*.json ./

# Copy orin-revamp directory with its package files
COPY orin-revamp/package*.json ./orin-revamp/

# Install all dependencies (including devDependencies for build)
RUN npm ci --no-optional
RUN cd orin-revamp && npm ci --no-optional

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
npm install --production && npm cache clean --force
