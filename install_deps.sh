#!/bin/bash
# install_deps.sh - Auto-install required tools for the Recon Framework

set -e

LOGDIR="logs"
mkdir -p "$LOGDIR"
LOGFILE="$LOGDIR/install_$(date +%Y%m%d_%H%M%S).log"
echo "[+] Starting dependency installation..." | tee -a "$LOGFILE"

# Update & base tools
sudo apt update && sudo apt install -y \
  nmap masscan fping netdiscover whatweb \
  dnsrecon dnsenum enum4linux-ng snmp snmpwalk \
  smtp-user-enum theharvester python3-pip \
  git netcat unzip curl whois \
  build-essential libpcap-dev jq | tee -a "$LOGFILE"

# Install Go if missing
if ! command -v go &> /dev/null; then
  echo "[+] Installing Go..." | tee -a "$LOGFILE"
  wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
  export PATH=$PATH:/usr/local/go/bin
fi

# Install Go tools
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/owasp-amass/amass/v4/...@master
sudo ln -sf ~/go/bin/* /usr/local/bin/

# Install Python packages
pip3 install -U pip
pip3 install pyshark shodan truffleHog jinja2

# Install RustScan
wget https://github.com/RustScan/RustScan/releases/latest/download/rustscan_2.1.1_amd64.deb
sudo dpkg -i rustscan_2.1.1_amd64.deb

# Clone SpiderFoot
mkdir -p tools && cd tools
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot && pip3 install -r requirements.txt && cd ../..

# Install Gitleaks
curl -s https://api.github.com/repos/gitleaks/gitleaks/releases/latest \
| grep browser_download_url | grep linux | cut -d '"' -f 4 \
| wget -qi - -O gitleaks.tar.gz
tar -xzf gitleaks.tar.gz gitleaks
sudo mv gitleaks /usr/local/bin/
rm gitleaks.tar.gz

# Download SecLists
if [ ! -d "wordlists" ]; then
  echo "[+] Downloading SecLists..." | tee -a "$LOGFILE"
  mkdir -p wordlists
  curl -L https://github.com/danielmiessler/SecLists/archive/refs/heads/master.zip -o wordlists/seclists.zip
  unzip wordlists/seclists.zip -d wordlists/ && mv wordlists/SecLists-master wordlists/SecLists && rm wordlists/seclists.zip
fi

echo "[✔] All dependencies installed!" | tee -a "$LOGFILE"
