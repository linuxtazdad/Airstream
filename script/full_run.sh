#!/bin/bash
#this is just the script that is going to be running everything
#it downloads and upload all files to dropbox thanks to 

dropbox='~/.dropscrit/dropbox_uploader.sh'

dropbox download invtory/invtory.csv invtory.csv

./Links.sh
./compare.sh

dropbox upload web_invtory.csv invtory/web_invtory.csv
dropbox upload dif_stock.csv invtory/dif_stock.csv

