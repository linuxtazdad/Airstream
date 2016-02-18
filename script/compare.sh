#!/bin/bash
#This file is to use the list from ADP with the web site.
#this space is for cleaning the list from ADP
#this is pulling the stock numbers from both files
cat invtory.csv|cut -d"," -f1>>stock_number.tmp
cat web_invtory.csv|cut -d"," -f1>>stock_number.tmp
sort stock_number.tmp|uniq -u>dif_stock.tmp


#this is where it starts comparring 
for i in $(cat dif_stock.tmp)
	do
	grep $i web_invtory.csv>>dif_stock.csv
	grep $i invtory.csv>> dif_stock.csv
	done
rm stock_number.tmp 
rm dif_stock.tmp
for i in $(cat needtoremove.run) ;do
sed -i "/$i/d" dif_stock.csv
done
