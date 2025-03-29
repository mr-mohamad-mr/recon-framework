#!/bin/bash
TARGET=$1
OUTDIR=$2

nmap -sV -p- --min-rate=1000 $TARGET -oN $OUTDIR/nmap.txt
masscan $TARGET -p1-65535 --rate=10000 -oG $OUTDIR/masscan.txt
rustscan -a $TARGET -- -sV > $OUTDIR/rustscan.txt

cat $OUTDIR/*.txt > $OUTDIR/port_scan.txt
