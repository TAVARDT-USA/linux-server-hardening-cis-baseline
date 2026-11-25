# Enterprise Linux Server Hardening Baseline

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Verification Suite](https://img.shields.io/badge/TAVARDT-Diagnostic%20Suite-5b3cf5.svg)](https://tools.tavardt.com/)
[![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash&logoColor=white)]
[![Security Baseline](https://img.shields.io/badge/CIS%20Benchmark-Level%201%20%26%202-00C853.svg)](https://ag.tavardt.com/cybersecurity/server-hardening/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

An automated baseline hardening framework, kernel parameter tuning profiles, and zero-trust perimeter configuration scripts aligned with **CIS Benchmarks** and **NIST Cybersecurity Framework (CSF 2.0)** for production Linux distributions (Ubuntu, Debian, RHEL, Rocky Linux).

Engineered and maintained by the infrastructure and cyber defence practice at **TAVARDT**.

***

## 1. Architectural Highlights

* **Automated System Hardening:** Ready-to-execute modular shell automation for rapid server commissioning.
* **Kernel Security (sysctl):** Restricts core dumps, enforces TCP SYN cookies, blocks source-routed packets, and enables address space layout randomization (ASLR).
* **SSH Zero-Trust Baseline:** Enforces Ed25519 key-only authentication, disables root login, restricts ciphers to post-quantum and modern curves, and limits authentication attempts.
* **Privilege & Audit Logging:** Integrates `auditd` surveillance for sensitive system calls and `/etc` modification events.

***

## 2. Hardening Matrix & Threat Controls

| Domain | Control Focus | Enforcement Mechanism |
|-|-|-|
| **Remote Access** | SSH key-only access on non-standard ports | `sshd_config` hardening with `PasswordAuthentication no` |
| **Network Stack** | Mitigation against SYN floods and IP spoofing | `sysctl` hardening profile (`/etc/sysctl.d/99-tavardt-security.conf`) |
| **Process Isolation** | Memory protection and restricted core dumps | `limits.conf` and `fs.protected_regular` parameters |
| **File Permissions** | World-writable audit and sensitive file access control | Automated `chmod` sweeps and SUID audit scripts |

***

## 3. Quick Start Deployment

Clone this repository to your target Linux server and execute the automated baseline hardening script:

```bash
git clone https://github.com/TAVARDT-USA/linux-server-hardening-cis-baseline.git
cd linux-server-hardening-cis-baseline
sudo bash scripts/harden-linux.sh -apply
```

### Dry-Run Verification Mode:
Run without modifying system state to audit your current perimeter compliance:
```bash
sudo bash scripts/harden-linux.sh -check-only
```

***

## 4. Online Diagnostic Tools (Global / USA)

Audit your public perimeter, SSL/TLS certificates, and application endpoints using the TAVARDT Diagnostic Suite:

* [HTTP Security Headers Checker](https://tools.tavardt.com/security-headers-check/): Tests HSTS, CSP, and X-Frame-Options.
* [Exposed Credentials & Secret Scanner](https://tools.tavardt.com/exposed-files-scanner/): Detects leaks of `.env`, `.git`, and database dumps.
* [DMARC & Email Spoofing Validator](https://tools.tavardt.com/dmarc-checker/): Protects enterprise domains from spoofing and BEC.
* Full Diagnostic Suite: 20 free technical tools.

***

## 5. Enterprise Cyber Defence & DFIR in the United States

Need senior engineering support for cloud architecture, SOC 2 / HIPAA compliance audits, or emergency breach containment?

* **Server Hardening Services:** https://ag.tavardt.com/cybersecurity/server-hardening/
* **DFIR & Breach Recovery:** [https://ag.tavardt.com/cybersecurity/digital-forensics-incident-response/](https://ag.tavardt.com/cybersecurity/digital-forensics-incident-response/)

***

## Useful Links

* **Corporate Portal:** https://ag.tavardt.com/
* **Diagnostic Suite:** https://tools.tavardt.com/
* **Technical Contact:** https://ag.tavardt.com/contact/

***

## License

Released under the MIT License. See [LICENSE](LICENSE) for full details.
***

© 2026 TAVARDT. All rights reserved.
