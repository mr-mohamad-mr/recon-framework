# parse_results.py - Extract summaries from module outputs

import sys
from pathlib import Path
import json
import re

TARGET = sys.argv[1]
OUTDIR = Path(sys.argv[2])
SUMMARY_FILE = OUTDIR / "summary.json"
summary = {}

# Parse Nmap results
def parse_nmap():
    nmap_file = OUTDIR / "nmap.txt"
    if nmap_file.exists():
        ports = re.findall(r"(\d+/tcp)\s+open", nmap_file.read_text())
        summary["open_ports"] = list(set(ports))

# Parse Subfinder/Amass subdomains
def parse_subdomains():
    subdomains = set()
    for f in ["subfinder.txt", "amass.txt"]:
        path = OUTDIR / f
        if path.exists():
            subdomains.update(path.read_text().splitlines())
    summary["subdomains"] = sorted(subdomains)

# Parse Gitleaks report
def parse_gitleaks():
    gitleaks_file = OUTDIR / "gitleaks.json"
    if gitleaks_file.exists():
        try:
            with open(gitleaks_file) as f:
                data = json.load(f)
                summary["secrets_found"] = len(data) if isinstance(data, list) else 0
        except Exception:
            summary["secrets_found"] = "Parse error"

# Run parsers
parse_nmap()
parse_subdomains()
parse_gitleaks()

# Write to summary file
with open(SUMMARY_FILE, "w") as f:
    json.dump(summary, f, indent=2)

print(f"[+] Summary written to {SUMMARY_FILE}")
