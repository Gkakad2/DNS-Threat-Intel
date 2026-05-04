# 🛡️ DNS Threat Intelligence Pipeline (RPZ + Sinkhole + IOC Detection)

---

## 📌 Overview

This project is a **DNS-based Threat Intelligence & Intrusion Prevention System (DNS-IPS)** that detects malicious domains in real time using **IOC threat feeds** and enforces blocking using:

- 🧠 BIND RPZ (Response Policy Zones)
- 🕳️ Sinkhole redirection
- 📊 Real-time DNS log analysis (Docker-based parser)

It helps identify:
- 🎯 Phishing domains  
- 🎯 Malware domains  
- 🎯 Command & Control (C2) infrastructure  

---

## 🏗️ Architecture

Client / Attacker VM
        │
        ▼
BIND DNS Resolver (RPZ Enabled)
        │
        ▼
DNS Query Logging (/var/log/named/query.log)
        │
        ▼
Docker Threat Parser Engine
        │
        ▼
IOC Matching Engine
(URLHaus | ThreatFox | OpenPhish)
        │
        ▼
Decision Engine
        │
   ┌────┴───────────────┐
   ▼                    ▼
CLEAN              MALICIOUS
Allow DNS          Block / Sinkhole
   │                    │
   └────────┬───────────┘
            ▼
   Enforcement Layer
   (RPZ / Sinkhole / NXDOMAIN)
            │
            ▼
Logging & Monitoring
(docker logs + DNS alerts)
---

## ⚙️ Features

- ⚡ Real-time DNS traffic monitoring
- 🧠 IOC-based threat detection engine
- 🛑 RPZ-based DNS blocking (inline IPS behavior)
- 🕳️ Sinkhole redirection for malware analysis
- 🐳 Fully containerized architecture (Docker)
- 📡 External threat intelligence feeds integration
- 📋 Whitelist-based domain bypass control
- 📊 DNS query logging & visibility

---

## 📁 Project Structure


DNS-Threat-Intel/
│
├── 🐳 docker-compose.yml
├── 🧱 parser/
│ ├── dns_parser.sh
│ ├── Dockerfile
│ ├── update_feeds.sh
│ └── feeds/
│ ├── urlhaus.txt
│ ├── threatfox.txt
│ └── openphish.txt
│
├── 🚫 blocked_domains.txt
├── 🧪 scripts/
│ └── test.sh
└── 📊 logs/


---

## 🧪 Testing Guide

### ✅ Test Clean Domain

dig google.com @<DNS_SERVER_IP> -p 5354


### ❌ Test Malicious Domain

dig evil-test.com @<DNS_SERVER_IP> -p 5354


### Expected Output

| Domain Type | Result |
|------------|--------|
| Clean Domain | 🌐 Resolved normally |
| Malicious Domain | 🚫 Blocked / Sinkholed |

---

## 📊 Logs & Monitoring

### 🧾 DNS Logs

tail -f /var/log/named/query.log


### 🐳 Parser Logs

docker logs -f dns-parser


---

## 🚀 Deployment

### Build & Run System

docker compose up --build -d


### Restart System

docker compose restart


---

## 🧠 Security Logic

- 📥 DNS queries are captured from BIND logs
- 🔍 Domains are extracted and normalized
- 🧠 Matched against IOC threat feeds
- ⚙️ Decision engine classifies traffic:
  - CLEAN → Allowed
  - IOC MATCH → Blocked
- 🚫 RPZ or Sinkhole action applied instantly

---

## 👨‍💻 Author

**DNS Threat Intelligence Pipeline Project**  
Built for SOC / Threat Detection / DNS Security Research

---
