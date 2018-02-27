#!/bin/bash
#This file is to use the list from ADP with the web site.
#this space is for cleaning the list from ADP
#this is pulling the stock numbers from both files
cat invtory.csv|cut -d"," -f13>>vin_number.tmp
cat web_invtory.csv|cut -d"," -f6|sed 's/\"//g'>>vin_number.tmp
sort vin_number.tmp|uniq -u>dif_vin.tmp
#removing after dealer spike change over no longer needed
#cat web_invtory.csv|awk -F, '$1 ~ /LA/'>> LA_invtory.csv

#this is where it starts comparring 
for i in $(cat dif_vin.tmp)
	do
	grep $i web_invtory.csv>>dif_stock
	grep $i invtory.csv>> dif_stock
	done
rm vin_number.tmp 
rm dif_vin.tmp
sort dif_stock|uniq -u >>dif_stock.csv
for i in $(cat needtoremove.run) ;do
sed -i "/$i/d" dif_stock.csv
done
rm LA_invtory.csv
