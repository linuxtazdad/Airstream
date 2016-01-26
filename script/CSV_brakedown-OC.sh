#!/bin/bash

#this is where the loop starts for the CSV file 
for i in $(cat links.txt) ;do
FILE_NAME=$(echo $i|sed 's/^.\{52\}//g'|sed 's/.\{14\}$//'|sed 's/-//')
echo $FILE_NAME
MODLE_YEAR=$(echo $i|sed 's/^.\{52\}//g'|sed 's/.\{14\}$//'|sed 's/\-/ /g'|sed 's/_/ /'|cut -d' ' -f1)
MODLE_MANF=$(echo $i|sed 's/^.\{52\}//g'|sed 's/.\{14\}$//'|sed 's/\-/ /g'|sed 's/_/ /'|cut -d' ' -f2)
MODLE_TYPE=$(echo $i|sed 's/^.\{52\}//g'|sed 's/.\{14\}$//'|sed 's/\-/ /g'|cut -d' ' -f3|sed 's/\_/ /g')
MODLE_TRIM=$(echo $i|sed 's/^.\{52\}//g'|sed 's/.\{14\}$//'|sed 's/\-/ /g'|sed 's/\(new\|used\)//g'|cut -d' ' -f4)
STOCK_TYPE=$(echo $i|sed 's/.\{14\}$//'|sed 's/.*-//g')
lynx -dump -accept_all_cookies $i >Files\/$FILE_NAME
#this group has to read the file not the "$i"
STOCK_NUMBER=$(cat Files\/$FILE_NAME|grep -i stock|sed 's/.*: //g'|cut -d' ' -f1)
VIN_NUMBER=$(cat Files\/$FILE_NAME|grep -i -A1 vin:|tail -n 1)
INT_COLOR=$(cat Files\/$FILE_NAME|grep -i -A1 "int color"|tail -n 1)
EXT_COLOR=$(cat Files\/$FILE_NAME|grep -i -A1 "color:"|tail -n 1)
PRICE_MARK=$(cat Files\/$FILE_NAME|grep 'Asking Price\|MSRP Price\|Sold'|cut -d':' -f1|tail -n1)
PRICE_SHOW=$(cat Files\/$FILE_NAME|		
let COUNT=COUNT+1
echo $COUNT
echo $STOCK_NUMBER,$VIN_NUMBER,$MODLE_YEAR,$MODLE_MANF,$MODLE_TYPE,$MODLE_TRIM,$STOCK_TYPE,$EXT_COLOR,$INT_COLOR,$PRICE_MARK,$PRICE_SHOW >>web_invtory.csv
echo $STOCK_NUMBER,$VIN_NUMBER,$MODLE_YEAR,$MODLE_MANF,$MODLE_TYPE,$MODLE_TRIM,$STOCK_TYPE,$EXT_COLOR,$INT_COLOR,$PRICE_MARK,$PRICE_SHOW,
echo sleeping
sleep 20
#rm -f Files\/$FILE_NAME
done 
