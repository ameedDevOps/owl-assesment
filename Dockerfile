# ===============================
# Stage 1: Dependency Builder
# ===============================
FROM node:20-alpine AS deps

WORKDIR /app

COPY app/package*.json ./

# Install prod deps AND clean npm cache
RUN npm ci --omit=dev \
 && npm cache clean --force \
 && rm -rf /root/.npm

# ===============================
# Stage 2: Runtime (Non-Root)
# ===============================
FROM node:20-alpine AS runtime

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy only node_modules (no npm cache)
COPY --from=deps /app/node_modules ./node_modules

# Copy app source
COPY app/server.js ./

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

RUN chown -R appuser:appgroup /app

USER appuser

CMD ["node", "server.js"]
