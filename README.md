# 🚀 DNS Threat Intelligence Pipeline (RPZ + Sinkhole + IOC Detection)

This project is a **DNS-based threat detection and prevention system** designed to identify malicious domains in real time using threat intelligence feeds and enforce blocking using RPZ and sinkhole techniques.

It is built as a **SOC-style DNS security pipeline** with full observability, automation, and containerized deployment.

---

# 🏗️ Technical Architecture

## 🔹 DNS Resolution Layer
- BIND DNS Resolver (RPZ Enabled)
- Handles all incoming DNS queries
- Applies policy-based filtering

---

## 🔹 Logging & Visibility Layer
- DNS query logs stored in: `/var/log/named/query.log`
- Provides raw telemetry for analysis

---

## 🔹 Threat Intelligence Layer
- Docker-based Threat Parser Engine
- Continuously reads DNS logs
- Extracts and normalizes domains
- Matches against IOC feeds:
  - URLHaus
  - ThreatFox
  - OpenPhish

---

## 🔹 Decision Engine
- CLEAN → Allow DNS response
- MALICIOUS → Block / Sinkhole

---

## 🔹 Enforcement Layer
- RPZ-based DNS blocking
- Sinkhole redirection
- NXDOMAIN response handling

---

## 🔹 Observability Layer
- docker logs (dns-parser)
- DNS classification logs
- Threat detection outputs

---

# 🛠️ Technical Stack

## Core DNS & Security
- BIND9 (DNS Server with RPZ)
- RPZ (Response Policy Zones)
- Sinkhole DNS redirection

## Threat Intelligence
- URLHaus feeds
- ThreatFox feeds
- OpenPhish feeds

## Processing & Automation
- Bash scripting (DNS parser engine)
- Cron-based feed updates
- Docker containerization

## Logging & Monitoring
- Docker logs
- BIND query logs
- Optional SIEM integration

---

# 📊 Data Flow

Client DNS Query  
→ BIND Resolver (RPZ Enabled)  
→ Query Logging Layer  
→ Threat Parser Engine (Docker)  
→ IOC Matching Engine  
→ Decision Engine  
→ Enforcement Layer (Allow / Block / Sinkhole)  
→ Logging & Monitoring  

---

# 📁 Repository Structure
DNS-Threat-Intel/
├── parser/
│ ├── dns_parser.sh
│ ├── update_feeds.sh
│ └── feeds/
│ ├── urlhaus.txt
│ ├── threatfox.txt
│ └── openphish.txt
│
├── configs/
│ ├── named.conf
│ └── rpz.zone
│
├── docker/
│ ├── Dockerfile
│ └── docker-compose.yml
│
├── scripts/
│ └── test.sh
│
└── logs/

---

# 🧪 Testing Methodology

## ✅ Test Clean Domain
```bash
dig google.com @<DNS_SERVER_IP> -p 5354

❌ Test Malicious Domain
dig evil-test.com @<DNS_SERVER_IP> -p 5354

📊 Expected Behavior
Domain Type	System Response
Clean Domain	DNS resolution allowed
Malicious Domain	Blocked / Sinkholed / NXDOMAIN

📜 Logging & Observability
DNS Logs
tail -f /var/log/named/query.log

Parser Logs
docker logs -f dns-parser

🚀 Deployment
docker compose up --build -d

👨‍💻 Author

DNS Threat Intelligence Pipeline
SOC / Cybersecurity / Threat Detection Project
