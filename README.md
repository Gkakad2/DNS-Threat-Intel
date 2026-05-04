# DNS Threat Intelligence Pipeline (RPZ + Sinkhole + IOC Feeds)

A containerized DNS security system that detects, classifies, and blocks malicious domains in real-time using threat intelligence feeds, BIND RPZ, and a DNS log-based detection engine.

---

## 🚀 Overview

This project builds a DNS-based threat detection and prevention system that:

- Monitors DNS queries in real-time  
- Matches domains against IOC threat feeds  
- Identifies malicious domains (phishing, malware, C2, etc.)  
- Blocks threats using BIND RPZ or Sinkhole responses  
- Runs fully in Docker for easy deployment  

---

## 🧠 Architecture

Client Devices (VM / Laptop)
        │
        ▼
BIND DNS Server (RPZ Enabled Resolver)
        │
        │  logs → /var/log/named/query.log
        ▼
DNS Log Collection Layer
        │
        ▼
DNS Threat Parser (Docker Container)
        │
        ├── IOC Feed Engine
        │     ├─ URLHaus
        │     ├─ ThreatFox
        │     ├─ OpenPhish
        │
        ├── Whitelist Filter
        │
        ▼
Decision Engine
        ├── CLEAN → allow DNS response
        └── MALICIOUS → block / sinkhole / RPZ
        │
        ▼
Response Enforcement Layer
        ├── BIND RPZ Zone Update
        ├── Sinkhole Redirect (fake IP)
        └── NXDOMAIN Response
        │
        ▼
Logging & Monitoring
        ├── docker logs dns-parser
        ├── BIND query logs
        └── IOC match reporting

---

## ⚙️ Features

- Real-time DNS traffic inspection  
- IOC-based threat detection engine  
- RPZ-based DNS blocking (inline IPS behavior)  
- Sinkhole integration for malware analysis  
- Fully containerized deployment (Docker)  
- External IOC feed support (URLHaus, ThreatFox, OpenPhish)  
- Whitelist filtering for trusted domains  
- Full DNS query logging and visibility  

---

## 🏗️ Project Structure

DNS-Threat-Intel/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── docs/
│   ├── architecture.md
│   ├── architecture.png
│   ├── test-plan.md
│   └── threat-model.md
│
├── src/
│   ├── parser/
│   │   ├── dns_parser.sh
│   │   ├── rpz_engine.sh
│   │   ├── sinkhole_handler.sh
│   │   └── utils.sh
│   │
│   ├── feeds/
│   │   ├── update_feeds.sh
│   │   ├── feed_loader.sh
│   │   └── whitelist.txt
│   │
│   └── config/
│       ├── rpz.zone
│       ├── named.conf.local
│       └── dns_config.conf
│
├── docker/
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── entrypoint.sh
│
├── tests/
│   ├── test_dns.sh
│   ├── test_malicious_domains.txt
│   └── test_clean_domains.txt
│
├── logs/
│   └── .gitkeep
│
├── data/
│   ├── blocked_domains.txt
│   ├── ioc_cache.db
│   └── sinkhole.log
│
└── scripts/
    ├── setup.sh
    ├── install_dependencies.sh
    ├── run.sh
    └── cleanup.sh

---

## ⚙️ Installation

### 1. Clone repository
```bash
git clone https://github.com/<your-username>/DNS-Threat-Intel.git
cd DNS-Threat-Intel
