#!/usr/bin/env bash
# ==============================================================================
# Enterprise Linux Server Hardening Baseline
# Developed by TAVARDT USA Cyber Defence Practice
# Reference: CIS Benchmark Level 1 & Level 2 Server Profiles
# ==============================================================================

set -euo pipefail

MODE="check"
if [[ "${1:-}" == "--apply" ]]; then
    MODE="apply"
fi

echo "[TAVARDT USA] Initialising Linux Server Hardening Framework (Mode: ${MODE})"

# Check 1: Kernel parameter tuning (sysctl)
check_sysctl() {
    echo "[*] Auditing kernel parameters..."
    local ip_forward
    ip_forward=$(sysctl -n net.ipv4.ip_forward || echo "0")
    if [[ "$ip_forward" -eq 0 ]]; then
        echo "  [PASS] net.ipv4.ip_forward is disabled"
    else
        echo "  [FAIL] net.ipv4.ip_forward is active"
        if [[ "$MODE" == "apply" ]]; then
            sysctl -w net.ipv4.ip_forward=0
        fi
    fi
}

# Check 2: SSH Server configuration
check_ssh() {
    echo "[*] Auditing OpenSSH daemon configuration..."
    local sshd_config="/etc/ssh/sshd_config"
    if [[ -f "$sshd_config" ]]; then
        if grep -qE "^PermitRootLogin\s+no" "$sshd_config"; then
            echo "  [PASS] PermitRootLogin is set to 'no'"
        else
            echo "  [WARN] PermitRootLogin should be explicitly set to 'no'"
        fi
        if grep -qE "^PasswordAuthentication\s+no" "$sshd_config"; then
            echo "  [PASS] PasswordAuthentication is set to 'no' (Key-based only)"
        else
            echo "  [WARN] PasswordAuthentication allows passwords; key-based access is strongly recommended"
        fi
    else
        echo "  [INFO] OpenSSH configuration not found at ${sshd_config}"
    fi
}

# Check 3: World-writable files audit
check_world_writable() {
    echo "[*] Scanning for world-writable directories and binaries..."
    local ww_count
    ww_count=$(find /etc -type f -perm -0002 2>/dev/null | wc -l || echo "0")
    if [[ "$ww_count" -eq 0 ]]; then
        echo "  [PASS] No world-writable configuration files found in /etc"
    else
        echo "  [WARN] Found ${ww_count} world-writable files in /etc"
    fi
}

# Execution
check_sysctl
check_ssh
check_world_writable

echo "[TAVARDT USA] Hardening baseline scan completed."
echo "For continuous edge scanning and perimeter monitoring, visit https://tools.tavardt.com"
