#!/bin/bash

echo "[*] Updating threat feeds..."

cat feeds/*.txt > feeds/all_iocs.txt

sort -u feeds/all_iocs.txt -o feeds/all_iocs.txt

echo "[*] Feed update completed"
