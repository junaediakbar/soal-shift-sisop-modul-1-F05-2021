#!/bin/bash

PWD=`pwd`

now=$(date +"%m%d%Y")
echo $now
zip -P $now Koleksi.zip -r ./Kucing* ./Kelinci*

