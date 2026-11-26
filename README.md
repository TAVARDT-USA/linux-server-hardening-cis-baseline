<p align="center">
  <a href="https://ag.tavardt.com/">
    <img src="https://ag.tavardt.com/img/tavardt-banner.png" alt="TAVARDT" width="1024" />
  </a>
</p>

# Linux Server Hardening CIS Baseline

[![Verification Suite](https://img.shields.io/badge/TAVARDT-Diagnostic%20Suite-5b3cf5.svg)](https://tools.tavardt.com/)
[![Security Baseline](https://img.shields.io/badge/CIS%20Benchmark-Level%201%20%26%202-00C853.svg)](https://ag.tavardt.com/cybersecurity/server-hardening/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

An automated baseline hardening framework, kernel parameter tuning profiles, and zero-trust perimeter configuration scripts aligned with **CIS Benchmarks** and **NIST Cybersecurity Framework (CSF 2.0)** for production Linux distributions.

Engineered and maintained by the infrastructure and cyber defence practice at **TAVARDT**.

***

## 1. Compliance Architecture and System Controls

Production server infrastructure requires deterministic technical controls to minimize attack surfaces and resist host compromise. The hardening framework audits and enforces essential security baselines across three core operating system layers:

* **Kernel Parameter Hardening (sysctl)**: Evaluates kernel routing tables and disables unneeded packet forwarding. It inspects `net.ipv4.ip_forward` to prevent multihomed hosts from acting as unauthenticated network routers.
* **OpenSSH Daemon Zero-Trust Access**: Enforces key-based administrative access policies in `/etc/ssh/sshd_config`. It audits `PermitRootLogin` to disable direct root sessions and verifies `PasswordAuthentication` to block credential stuffing.
* **File System Integrity and World-Writable Audits**: Performs recursive sweeps across `/etc` to identify configuration files with permissive access rights. It flags any system asset possessing world-writable bitmask permissions (`perm -0002`).

***

## 2. Threat Vectors and Operational Risk Mitigation

Unmanaged Linux hosts deployed with default vendor settings expose private networks to lateral movement and privilege escalation. The hardening framework mitigates four critical operational risk vectors:

* **Host-Level Packet Routing and Pivoting**: Enabled IP forwarding allows attackers on compromised hosts to route traffic into protected VPC segments. Disabling IP forward directives confines network traffic strictly to designated ingress conduits.
* **Automated SSH Brute-Force and Credential Stuffing**: Allowing password-based authentication permits continuous dictionary attacks against administrative daemons. Mandating cryptographic public keys eliminates password spray vectors entirely.
* **Direct Root Account Compromise**: Unrestricted root access over SSH provides adversaries with immediate full system control upon authentication. Enforcing non-root logins ensures accountability through audited `sudo` elevation logs.
* **Privilege Escalation via World-Writable Files**: Configuration files modifiable by unprivileged accounts enable local attackers to alter scheduled tasks, service parameters, or library paths. Removing world-writable permissions preserves operating system integrity.

***

## 3. Quick Start and Operational Verification

Run the automated baseline compliance audit locally across target Linux distributions using POSIX Bash:

```bash
git clone https://github.com/TAVARDT-USA/linux-server-hardening-cis-baseline.git
cd linux-server-hardening-cis-baseline
sudo bash scripts/harden-linux.sh
```

### Execution Modes and Status Evaluation

The inspection utility provides deterministic output classifications for each audited system control:

* **Hardened Control Confirmed (`[PASS]`)**: Indicates that the inspected parameter (such as disabled IP forwarding, restricted SSH root access, or protected directory permissions) satisfies CIS baseline requirements.
* **Security Deviation Detected (`[FAIL]` / `[WARN]`)**: Highlights active packet forwarding, password authentication permissions, or world-writable files in `/etc` that require immediate remediation.

***

## 4. Frequently Asked Technical Questions (FAQ)

### How does the hardening script audit and remediate kernel packet forwarding?
The script queries the net.ipv4.ip_forward sysctl parameter to verify that routing and packet forwarding between network interfaces remain disabled. If packet forwarding is unexpectedly active, the tool flags an immediate failure to prevent the host from operating as an unauthorized transit gateway.

### What specific SSH daemon configurations are enforced to establish a zero-trust access baseline?
The framework parses /etc/ssh/sshd_config to mandate that PermitRootLogin and PasswordAuthentication directives are strictly disabled. Enforcing these parameters eliminates brute-force dictionary attacks by requiring cryptographic public-key authentication for all administrative sessions.

### Why is scanning for world-writable configuration files in /etc critical for server security?
Files configured with world-writable permissions allow any unprivileged local user or compromised service to modify system configurations. The audit script searches /etc for files with permission bit 0002 to identify privilege escalation vectors and unauthorized tampering risks.

### How does the script support dry-run audit operations without modifying system state?
Executing the script without modification flags runs the utility in check mode, performing read-only inspections of kernel parameters, SSH daemon settings, and directory permissions. This non-disruptive inspection generates immediate compliance diagnostic logs without altering running services or host configurations.

### What operational remediation steps should engineers follow when a security check fails?
System administrators should adjust sysctl configuration files to persist disabled IP forwarding across reboots and update sshd_config before reloading the OpenSSH daemon. For world-writable files, permissions should be restricted immediately using chmod to restrict write access to the root user.

***

## Useful Links

* **Corporate Portal:** https://ag.tavardt.com/
* **Diagnostic Suite:** https://tools.tavardt.com/
* **Technical Contact:** https://ag.tavardt.com/contact/

***

## License

Released under the MIT License.

***

© 2026 TAVARDT. All rights reserved.
