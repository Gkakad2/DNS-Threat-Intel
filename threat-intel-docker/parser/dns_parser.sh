#!/bin/bash

LOG_FILE="/logs/query.log"
IOC_FILE="/app/feeds/all_iocs.txt"

echo "[*] DNS Threat Parser LIVE STARTED"
echo "[*] Watching: $LOG_FILE"
echo "[*] IOC Feed: $IOC_FILE"
echo "----------------------------------------------------"

tr -d '\r' < "$IOC_FILE" | sort -u > /tmp/ioc_clean.txt

tail -n 0 -F "$LOG_FILE" | while read -r line; do

    [[ "$line" != *"query:"* ]] && continue

    TIME=$(echo "$line" | awk '{print $1, $2}')

    CLIENT=$(echo "$line" | awk '{
        for(i=1;i<=NF;i++){
            if($i ~ /#/){
                split($i,a,"#");
                print a[1];
                break;
            }
        }
    }')

    DOMAIN=$(echo "$line" | awk -F'query: ' '{print $2}' | awk '{print $1}')
    DOMAIN=$(echo "$DOMAIN" | tr 'A-Z' 'a-z' | sed 's/\.$//')

    [[ -z "$DOMAIN" ]] && continue

    BASE_DOMAIN=$(echo "$DOMAIN" | awk -F. '{if (NF>=2) print $(NF-1)"."$NF; else print $0}')

    SUB=$(echo "$DOMAIN" | cut -d'.' -f1)

    LEN=${#SUB}
    DIGITS=$(echo "$SUB" | tr -cd '0-9' | wc -c | tr -d ' ')
    LABELS=$(echo "$DOMAIN" | awk -F'.' '{print NF}')

    RESULT="CLEAN"

    # -----------------------------
    # 1. EXACT IOC
    # -----------------------------
    if grep -Fxq "$DOMAIN" /tmp/ioc_clean.txt; then
        RESULT="IOC MATCH (MALICIOUS)"

    else
        # -----------------------------
        # 2. DGA (HEX / RANDOM ONLY)
        # -----------------------------
        if echo "$SUB" | grep -Eq '^[a-f0-9]{20,}$'; then
            RESULT="SUSPICIOUS (DGA/BEACON)"

        # -----------------------------
        # 3. PHISHING
        # -----------------------------
        elif echo "$DOMAIN" | grep -Eqi "(login|verify|update|secure|account|bank|paypal)"; then
            RESULT="SUSPICIOUS (PHISHING)"

        # -----------------------------
        # 4. MULTI-SUBDOMAIN
        # -----------------------------
        elif [ "$LABELS" -ge 4 ]; then
            RESULT="SUSPICIOUS (MULTI-SUBDOMAIN)"

        # -----------------------------
        # 5. BASE DOMAIN IOC
        # -----------------------------
        elif grep -Fxq "$BASE_DOMAIN" /tmp/ioc_clean.txt; then
            RESULT="IOC MATCH (BASE DOMAIN)"
        fi
    fi

    echo "----------------------------------------------------"
    echo "[TIME]   $TIME"
    echo "[CLIENT] $CLIENT"
    echo "[DOMAIN] $DOMAIN"
    echo "[RESULT] $RESULT"

done
