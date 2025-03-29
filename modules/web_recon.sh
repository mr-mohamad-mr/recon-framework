#!/bin/bash
TARGET=$1
OUTDIR=$2

whatweb $TARGET > $OUTDIR/whatweb.txt
nmap -p 80,443 --script http-enum,http-title,http-server-header $TARGET -oN $OUTDIR/nmap_http.txt

cat $OUTDIR/*.txt > $OUTDIR/web_recon.txt
