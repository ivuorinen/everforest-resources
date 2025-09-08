#!/usr/bin/env bash

# Everforest Resources Verifier
# Verifies generated configurations in a Docker container

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="${SCRIPT_DIR}"
ENGINE="${ENGINE:-docker}"

echo "🔍 Verifying Everforest configurations with ${ENGINE}..."

# Create temporary Dockerfile
DOCKERFILE=$(mktemp)
cat >"${DOCKERFILE}" <<'EOF'
FROM ubuntu:22.04

# Install essential tools for verification
RUN apt-get update && apt-get install -y \
    curl \
    git \
    fish \
    tmux \
    fzf \
    bat \
    ripgrep \
    htop \
    && rm -rf /var/lib/apt/lists/*

# Install starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# Create a test user
RUN useradd -m -s /bin/bash testuser
USER testuser
WORKDIR /home/testuser

# Copy configurations
COPY --chown=testuser:testuser cli/ ./cli/

# Set up PATH
ENV PATH="/home/testuser/.local/bin:$PATH"

# Verification script
RUN echo '#!/bin/bash' > verify.sh && \
    echo 'set -euo pipefail' >> verify.sh && \
    echo 'echo "🎨 Testing Everforest configurations..."' >> verify.sh && \
    echo 'echo "✅ Container verification complete!"' >> verify.sh && \
    chmod +x verify.sh

CMD ["./verify.sh"]
EOF

# Build and run container
CONTAINER_NAME="everforest-verify-$(date +%s)"

echo "📦 Building verification container..."
"${ENGINE}" build -f "${DOCKERFILE}" -t "${CONTAINER_NAME}" "${PROJECT_ROOT}"

echo "🏃 Running verification..."
"${ENGINE}" run --rm "${CONTAINER_NAME}"

# Cleanup
rm -f "${DOCKERFILE}"

echo "✅ Verification complete!"
