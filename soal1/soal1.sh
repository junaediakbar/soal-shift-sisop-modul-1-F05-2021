#!/bin/bash
 
#soal 1a
 
log=`cat syslog.log | cut -f6- -d' '`

#soal 1b
err=`grep "ERROR" "syslog.log" | cut -d' ' -f7- | cut -d'(' -f1 | sort | uniq -c`

#soal 1c
counterr=`grep "ERROR" "syslog.log"| cut -d'(' -f2 | cut -d')' -f1 | sort | uniq -c`
countin=`grep "INFO" "syslog.log"| cut -d'(' -f2 | cut -d')' -f1 | sort | uniq -c`