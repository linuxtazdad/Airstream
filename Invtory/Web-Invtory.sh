#!/bin/bash
##This file is to pull and put the web_invtory in dropbox for the other scripts
##to uses it as needed.


###ALA web site pull
wget -q -O ALA-web_invtory.csv "www.airstreamlosangeles.com/feeds.asp?feed=GenericCSVFeed"
dropbox upload ALA-web_invtory.csv Invtory/Web-site/
###AOC Web site pull
wget -q -O AOC-web_invtory.csv "www.airstreamlosangeles.com/feeds.asp?feed=GenericCSVFeed"
dropbox upload AOC-web_invtory.csv Invtory/Web-site/
###AIE web site pull
wget -q -O AIE-web_invtory.csv "www.airstreamlosangeles.com/feeds.asp?feed=GenericCSVFeed"
dropbox upload AIE-web_invtory.csv Invtory/Web-site/
###ALV web site pull
wget -q -O ALV-web_invtory.csv "www.airstreamlosangeles.com/feeds.asp?feed=GenericCSVFeed"
dropbox upload ALV-web_invtory.csv Invtory/Web-site/
###Cleaning up Files
rm *-web_invtory.csv
