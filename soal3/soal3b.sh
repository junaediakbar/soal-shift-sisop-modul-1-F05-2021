#!/bin/bash

PWD=`pwd`

bash /home/juned/soal-shift-sisop-modul-1-F05-2021/soal3a.sh
now=$(date +"%d-%m-%Y")
mkdir "$now"

mv /home/juned/soal-shift-sisop-modul-1-F05-2021/Koleksi_* "./$now"
mv /home/juned/soal-shift-sisop-modul-1-F05-2021/Foto.log "./$now"
