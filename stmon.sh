#!/usr/bin/env bash
# ==============================================================================
# Script Name : stmon
# Description : A modern, professional CLI utility to display system uptime 
#               and active session duration on Linux distributions.
# Author      : Open Source Community
# License     : MIT
# Version     : 1.0.0
# ==============================================================================

# Strict mode for safer shell scripting
set -euo pipefail
IFS=$'\n\t'

# --- Colors and Formatting ---
readonly C_RESET='\e[0m'
readonly C_BOLD='\e[1m'
readonly C_DIM='\e[2m'
readonly C_BLUE='\e[34m'
readonly C_CYAN='\e[36m'
readonly C_GREEN='\e[32m'
readonly C_YELLOW='\e[33m'
readonly C_RED='\e[31m'

# --- Helper Functions ---

print_help() {
    cat << EOF
${C_BOLD}Usage:${C_RESET} ${0##*/} [OPTIONS]

A professional utility to display how much time your Linux machine has been
continuously running, along with session details.

${C_BOLD}Options:${C_RESET}
    -h, --help      Display this help message and exit
    -v, --version   Display version information and exit
    -s, --short     Display only the total uptime in a short format
    -j, --json      Output the screen time data in JSON format

${C_BOLD}Examples:${C_RESET}
    ${0##*/}
    ${0##*/} --short
    ${0##*/} --json
EOF
}

print_version() {
    echo -e "${C_BOLD}screentime${C_RESET} version 1.0.0"
    echo "License: MIT"
}

format_time() {
    local total_seconds=$1
    local days=$((total_seconds / 86400))
    local hours=$(( (total_seconds % 86400) / 3600 ))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))

    local result=""
    [[ $days -gt 0 ]] && result="${days}d "
    [[ $hours -gt 0 ]] && result="${result}${hours}h "
    [[ $minutes -gt 0 ]] && result="${result}${minutes}m "
    result="${result}${seconds}s"
    
    echo "$result"
}

get_os_info() {
    if [[ -f /etc/os-release ]]; then
        # shellcheck source=/dev/null
        source /etc/os-release
        echo "${PRETTY_NAME:-Unknown Linux}"
    else
        uname -sr
    fi
}

main() {
    local short_mode=false
    local json_mode=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                print_help
                exit 0
                ;;
            -v|--version)
                print_version
                exit 0
                ;;
            -s|--short)
                short_mode=true
                shift
                ;;
            -j|--json)
                json_mode=true
                shift
                ;;
            *)
                echo -e "${C_RED}Error: Unknown option: $1${C_RESET}" >&2
                print_help >&2
                exit 1
                ;;
        esac
    done

    # Get system boot time and uptime
    if [[ ! -f /proc/uptime ]]; then
        echo -e "${C_RED}Error: /proc/uptime not found. This script is designed for Linux.${C_RESET}" >&2
        exit 1
    fi

    # Read uptime
    local uptime_seconds
    uptime_seconds=$(awk '{print int($1)}' /proc/uptime)

    if [[ "$short_mode" == true ]]; then
        format_time "$uptime_seconds"
        exit 0
    fi

    # Gather additional info
    local os_info
    os_info=$(get_os_info)
    
    local load_avg
    load_avg=$(awk '{print $1", "$2", "$3}' /proc/loadavg)

    local current_time
    current_time=$(date "+%Y-%m-%d %H:%M:%S")

    local boot_time
    boot_time=$(date -d "@$(( $(date +%s) - uptime_seconds ))" "+%Y-%m-%d %H:%M:%S")
    
    local active_users
    active_users=$(who | wc -l)
    
    local current_user
    current_user=$(whoami)

    # JSON Output
    if [[ "$json_mode" == true ]]; then
        cat << EOF
{
  "os": "$os_info",
  "current_time": "$current_time",
  "boot_time": "$boot_time",
  "uptime_seconds": $uptime_seconds,
  "uptime_formatted": "$(format_time "$uptime_seconds")",
  "load_average": "$load_avg",
  "active_users_count": $active_users,
  "current_user": "$current_user"
}
EOF
        exit 0
    fi

    # Print Dashboard
    echo -e "\n${C_CYAN}${C_BOLD}╭────────────────────────────────────────────────────────╮${C_RESET}"
    echo -e "${C_CYAN}${C_BOLD}│             SYSTEM SCREEN TIME & UPTIME                │${C_RESET}"
    echo -e "${C_CYAN}${C_BOLD}╰────────────────────────────────────────────────────────╯${C_RESET}\n"
    
    echo -e "  ${C_BOLD}Operating System:${C_RESET} ${C_BLUE}${os_info}${C_RESET}"
    echo -e "  ${C_BOLD}Current User:${C_RESET}     ${current_user}"
    echo -e "  ${C_BOLD}Current Time:${C_RESET}     ${C_DIM}${current_time}${C_RESET}"
    echo -e "  ${C_BOLD}System Boot Time:${C_RESET} ${C_DIM}${boot_time}${C_RESET}\n"
    
    echo -e "  ${C_YELLOW}${C_BOLD}Continuous Running Time (Screen Time):${C_RESET}"
    echo -e "  ${C_GREEN}${C_BOLD}► $(format_time "$uptime_seconds")${C_RESET}\n"
    
    echo -e "  ${C_BOLD}System Load:${C_RESET}      ${load_avg}"
    echo -e "  ${C_BOLD}Active Sessions:${C_RESET}  ${active_users}"
    echo ""
}

main "$@"
