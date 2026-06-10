#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="/opt/datalab/init.log"

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log_message "Starting user initialization..."

# --- Source conda profile --------------------------------------------------
CONDA_BASE="$(conda info --base)"
# shellcheck disable=SC1091
source "$CONDA_BASE/etc/profile.d/conda.sh"
log_message "Sourced conda profile (base: $CONDA_BASE)"

# --- (Optional) Activate a custom conda environment -----------------------
# conda activate myenv

# --- (Optional) Clone or update a repository ------------------------------
# REPO_DIR="/media/home/my_repo"
# if [ -d "$REPO_DIR/.git" ]; then
#     git -C "$REPO_DIR" pull || log_message "WARNING: git pull failed"
# else
#     git clone https://example.com/repo.git "$REPO_DIR"
# fi

log_message "User initialization completed at: $(date)"
