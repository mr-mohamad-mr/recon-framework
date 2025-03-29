#!/bin/bash
TARGET=$1
OUTDIR=$2

subfinder -d $TARGET -silent > $OUTDIR/subfinder.txt
amass enum -d $TARGET -o $OUTDIR/amass.txt
dnsrecon -d $TARGET -a > $OUTDIR/dnsrecon.txt
dnsenum $TARGET > $OUTDIR/dnsenum.txt

cat $OUTDIR/*.txt > $OUTDIR/dns_enum.txt
