#!/bin/bash
TARGET=$1
OUTDIR=$2

theHarvester -d $TARGET -b all -f $OUTDIR/harvester.html
shodan host $TARGET > $OUTDIR/shodan.txt

cat $OUTDIR/shodan.txt > $OUTDIR/osint_enum.txt
