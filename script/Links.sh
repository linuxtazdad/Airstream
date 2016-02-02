#!/bin/bash
#this script pulles the invtory lins from Ebiz auto for a single store
#below is where the url is set 
# this could be a good scritp for pulling only a set kind of link off any web site list.
URL='http://air-stream-los-angeles.ebizautos.com/inventory.aspx'
EXTRA='_page=' 
PAGE=1
MORE_PAGE=2
while [ $MORE_PAGE \> "1" ] ;do
	sleep 	1
	lynx -dump -source -accept_all_cookies  "$URL?$EXTRA$PAGE">dump.tmp 
	#echo Lynx 
	grep detail dump.tmp |sed -ne 's/.*\(http[^"]*\).*/\1/p'|sed 's/..$//'>>links.txt 
	#this command is not working the way it needs to look in to it latter 
	let MORE_PAGE=$(grep -c next dump.tmp) 
	let PAGE=PAGE+1
	#echo sleeping
	sleep 30
	#rm dump.tmp
done

#wc -l links.txt


