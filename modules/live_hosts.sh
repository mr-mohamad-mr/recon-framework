#!/bin/bash
TARGET=$1
OUTDIR=$2

fping -a -g $TARGET/24 2>/dev/null > $OUTDIR/fping.txt
netdiscover -r $TARGET/24 -P -N > $OUTDIR/netdiscover.txt

cat $OUTDIR/*.txt > $OUTDIR/live_hosts.txt
