#!/bin/bash
TARGET=$1
OUTDIR=$2

nmap -O $TARGET -oN $OUTDIR/nmap_os.txt
nc -vz $TARGET 1-1000 > $OUTDIR/netcat.txt

cat $OUTDIR/*.txt > $OUTDIR/fingerprint.txt
