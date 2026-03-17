#!/bin/bash
# Auto-commit hook: stages, commits, pulls --rebase, pushes
# Receives JSON on stdin from PostToolUse event

set -e

cd /Users/bru/Desktop/projects/cloudseedsDiscovery

# Extract file path from tool input
FILE=$(jq -r '.tool_input.file_path // .tool_response.filePath // "unknown"' 2>/dev/null)
FILENAME=$(basename "$FILE" 2>/dev/null || echo "unknown")

# Check if there are actual changes
if git diff --quiet HEAD 2>/dev/null && git diff --cached --quiet 2>/dev/null && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    exit 0
fi

# Stage all changes
git add -A

# Commit with descriptive message
git commit -m "auto: update ${FILENAME}" --no-verify 2>/dev/null || exit 0

# Pull with rebase to handle any remote changes / merge conflicts
git pull --rebase origin main 2>/dev/null || {
    # If rebase fails due to conflicts, abort and try merge
    git rebase --abort 2>/dev/null || true
    git pull origin main --no-edit 2>/dev/null || {
        # Auto-resolve conflicts by accepting ours
        git checkout --ours . 2>/dev/null || true
        git add -A
        git commit -m "auto: resolve merge conflicts (accept ours)" --no-verify 2>/dev/null || true
    }
}

# Push
git push origin main 2>/dev/null || true
