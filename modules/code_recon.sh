#!/bin/bash
TARGET=$1
OUTDIR=$2

gitleaks detect -s . --report-format=json --report-path=$OUTDIR/gitleaks.json
trufflehog filesystem . --json > $OUTDIR/trufflehog.json
