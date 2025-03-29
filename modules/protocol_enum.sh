#!/bin/bash
TARGET=$1
OUTDIR=$2

enum4linux-ng $TARGET > $OUTDIR/enum4linux.txt
snmpwalk -c public -v1 $TARGET > $OUTDIR/snmpwalk.txt
smtp-user-enum -M VRFY -U /usr/share/seclists/Usernames/top-usernames-shortlist.txt -t $TARGET > $OUTDIR/smtp_enum.txt
nmap -sV --script=default,safe $TARGET -oN $OUTDIR/nmap_protocol.txt

cat $OUTDIR/*.txt > $OUTDIR/protocol_enum.txt
