# report_generator.py - Enhanced HTML report builder using Jinja2

import sys
import json
from pathlib import Path
from jinja2 import Environment, FileSystemLoader

TARGET = sys.argv[1]
OUTDIR = Path(sys.argv[2])
REPORTS_DIR = Path("reports")
TEMPLATE_DIR = Path("templates")
SUMMARY_FILE = OUTDIR / "summary.json"
REPORTS_DIR.mkdir(exist_ok=True)

# Load summary
summary = {}
if SUMMARY_FILE.exists():
    with open(SUMMARY_FILE) as f:
        summary = json.load(f)

# Load Jinja2 template
env = Environment(loader=FileSystemLoader(str(TEMPLATE_DIR)))
template = env.get_template("report_template.html")

# Read raw module outputs
raw_outputs = {}
for file in OUTDIR.glob("*.txt"):
    raw_outputs[file.name] = file.read_text()

# Render HTML
html_report = template.render(target=TARGET, summary=summary, raw_outputs=raw_outputs)
output_path = REPORTS_DIR / f"{TARGET}.html"
output_path.write_text(html_report)

print(f"[+] HTML report created at {output_path}")
