#!/bin/bash

PWD=`pwd`

now=$(date +"%m%d%Y")
zip -P $now Koleksi.zip -r ./Kucing* ./Kelinci*

