# 🚀 DNS Threat Intelligence Pipeline (RPZ + Sinkhole + IOC Detection)

This project is a **DNS-based threat detection and prevention system** designed to identify malicious domains in real time using threat intelligence feeds and enforce blocking using RPZ and sinkhole techniques.

It is built as a **SOC-style DNS security pipeline** with full observability, automation, and containerized deployment.

---

# 🏗️ Technical Architecture

The system is designed in layered architecture to ensure scalability and separation of concerns:

### 🔹 DNS Resolution Layer
- BIND DNS Resolver (RPZ Enabled)
- Handles all incoming DNS queries
- Applies policy-based filtering

### 🔹 Logging & Visibility Layer
- DNS query logs stored in:
  `/var/log/named/query.log`
- Provides raw telemetry for analysis

### 🔹 Threat Intelligence Layer
- Docker-based Threat Parser Engine
- Continuously reads DNS logs
- Extracts and normalizes queried domains
- Matches against IOC feeds:
  - URLHaus
  - ThreatFox
  - OpenPhish

### 🔹 Decision Engine
- Classifies domains into:
  - CLEAN → Allowed
  - MALICIOUS → Blocked

### 🔹 Enforcement Layer
- RPZ-based DNS blocking
- Sinkhole redirection for malicious domains
- NXDOMAIN response handling

### 🔹 Observability Layer
- Docker logs (`dns-parser`)
- DNS classification logs
- Threat detection outputs
- Real-time alert visibility

---

# 🛠️ Technical Stack

### Core DNS & Security
- BIND9 (DNS Server with RPZ)
- RPZ (Response Policy Zones)
- Sinkhole DNS redirection

### Threat Intelligence
- URLHaus feeds
- ThreatFox feeds
- OpenPhish feeds

### Processing & Automation
- Bash scripting (DNS parser engine)
- Cron / scheduled feed updates
- Docker containerization

### Logging & Monitoring
- Docker logs
- BIND query logs
- Optional SIEM integration (future-ready)

---

# ⚙️ Key Implementation Details

## 1. DNS Monitoring Pipeline
- All DNS queries are captured via BIND logging
- Logs are streamed into the parser engine container

## 2. Threat Detection Engine
- Domains extracted from query logs
- Normalized and deduplicated
- Matched against IOC datasets

## 3. Policy Enforcement
- If domain matches IOC → blocked via RPZ
- Otherwise → allowed resolution

## 4. Sinkhole Mechanism
- Malicious domains redirected to controlled IP
- Enables analysis of attacker behavior

---

# 🛡️ Security Capabilities

- 🧠 Real-time IOC-based detection
- 🚫 DNS-level blocking (pre-network execution)
- 🕳️ Sinkhole malware redirection
- 📊 Full query visibility & logging
- 🔍 Threat intelligence enrichment
- 🐳 Containerized security pipeline

---

# 📊 Data Flow

Client DNS Query  
→ BIND Resolver (RPZ Enabled)  
→ Query Logging Layer  
→ Threat Parser (Docker Engine)  
→ IOC Matching Engine  
→ Decision Engine  
→ Enforcement Layer (Block / Allow / Sinkhole)  
→ Logging & Monitoring

---

# 📁 Repository Structure

DNS-Threat-Intel/
│
├── parser/ # DNS threat parser engine
│ ├── dns_parser.sh
│ ├── update_feeds.sh
│ └── feeds/
│ ├── urlhaus.txt
│ ├── threatfox.txt
│ └── openphish.txt
│
├── configs/ # BIND / RPZ configuration
│ ├── named.conf
│ └── rpz.zone
│
├── docker/ # Container setup
│ ├── Dockerfile
│ └── docker-compose.yml
│
├── scripts/ # Automation scripts
│ └── test.sh
│
└── logs/ # DNS and parser logs


---

# 🧪 Testing Methodology

### ✅ Test Clean Domain
```bash
dig google.com @<DNS_SERVER_IP> -p 5354

❌ Test Malicious Domain
dig evil-test.com @<DNS_SERVER_IP> -p 5354

# 📊 Expected Behavior
Domain Type	System Response
Clean Domain	DNS resolution allowed
Malicious Domain	Blocked / Sinkholed / NXDOMAIN
# 📜 Logging & Observability
DNS Logs
tail -f /var/log/named/query.log
Parser Logs
docker logs -f dns-parser
# 🚀 Deployment
docker compose up --build -d

#👨‍💻 Author

DNS Threat Intelligence Pipeline
SOC / Cybersecurity / Threat Detection Project
