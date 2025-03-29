# 🔍 Recon Framework

A modular, extensible recon and information gathering framework powered by Bash + Python.

## ✨ Features

- 🧩 Modular architecture (plugins & modules auto-detected)
- 🌐 DNS, Port, OSINT, Live Host, Web, Protocol, and Code enumeration
- 🧠 Result summarization & secret detection
- 📊 Beautiful HTML reports with charts using Jinja2
- 📦 Auto-installer + SecLists downloader
- 📝 Logging + metadata tracking

## 🚀 Quick Start

```bash
git clone https://github.com/yourusername/recon-framework.git
cd recon-framework
chmod +x core.sh install_deps.sh
./install_deps.sh
./core.sh example.com
