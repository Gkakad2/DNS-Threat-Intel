#!/bin/bash

DNS_SERVER=$1
PORT=5354

if [ -z "$DNS_SERVER" ]; then
  echo "Usage: $0 <DNS_SERVER_IP>"
  exit 1
fi

echo "===== DNS Threat Intel Test ====="

echo "[+] Testing normal domains"
for d in google.com wikipedia.org amazon.in; do
  echo "Testing $d"
  dig $d @$DNS_SERVER -p $PORT +short
done

echo ""
echo "[+] Testing malicious domains"
for d in evil-test.com malicious-test.com badactor.xyz; do
  echo "Testing $d"
  dig $d @$DNS_SERVER -p $PORT
done

echo ""
echo "[+] Check logs on server:"
echo "docker logs -f dns-parser"
