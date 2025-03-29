#!/bin/bash
# core.sh - Main orchestrator for the Recon Framework

CONFIG="config.yaml"
TARGET=$1
if [ -z "$TARGET" ]; then
    echo "Usage: ./core.sh <target>"
    exit 1
fi

OUTDIR="output/$TARGET"
LOGDIR="logs"
LOGFILE="$LOGDIR/recon_${TARGET}_$(date +%Y%m%d_%H%M%S).log"
mkdir -p "$OUTDIR" "$LOGDIR"
echo "[*] Starting recon for $TARGET" | tee "$LOGFILE"

# Run all .sh modules
for mod in modules/*.sh; do
    echo "[*] Running $(basename "$mod")..." | tee -a "$LOGFILE"
    bash "$mod" "$TARGET" "$OUTDIR" >> "$LOGFILE" 2>&1
    echo "[✔] Completed $(basename "$mod")" | tee -a "$LOGFILE"
done

# Run all .py plugins
for plugin in plugins/*.py; do
    echo "[*] Running $(basename "$plugin")..." | tee -a "$LOGFILE"
    python3 "$plugin" "$TARGET" "$OUTDIR" >> "$LOGFILE" 2>&1
    echo "[✔] Completed $(basename "$plugin")" | tee -a "$LOGFILE"
done

# Parse results
echo "[*] Parsing results..." | tee -a "$LOGFILE"
python3 parse_results.py "$TARGET" "$OUTDIR" >> "$LOGFILE" 2>&1

# Generate report
echo "[*] Generating enhanced HTML report..." | tee -a "$LOGFILE"
python3 utils/report_generator.py "$TARGET" "$OUTDIR" >> "$LOGFILE" 2>&1

echo "[✔] Recon complete. Report saved to reports/${TARGET}.html" | tee -a "$LOGFILE"
