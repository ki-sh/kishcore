#!/usr/bin/env bash
# from https://github.com/gruntwork-io/bash-commons

YELLOW=$(tput setaf 3)
NORMAL=$(tput sgr0)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)

# Echo to stderr. Useful for printing script usage information.
function echo_stderr {
  >&2 echo "$@"
}

# Log the given message at the given level. All logs are written to stderr with a timestamp.
function log {
  local -r level="$1"
  local -r message="$2"
  local -r timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  local -r script_name="$(basename "$0")"
  echo_stderr -e "${LIME_YELLOW} [${level}] [$script_name] ${message}${NORMAL}" # ${timestamp}
}

# Log the given message at INFO level. All logs are written to stderr with a timestamp.
function log_info {
  # todo: log levels - turn on/off easily.
  # return 0
  local -r message="$1"
  log "INFO" "$message"
}

# Log the given message at WARN level. All logs are written to stderr with a timestamp.
function log_warn {
  local -r message="$1"
  log "WARN" "$message"
}

# Log the given message at ERROR level. All logs are written to stderr with a timestamp.
function log_error {
  local -r message="$1"
  log "ERROR" "$message"
}
