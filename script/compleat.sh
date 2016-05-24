!#/bin/bash
//this is just a easy way to get it all taken care of.

Links.sh

./Links.sh
dropbox download invtory/invtory.csv
./compare.sh
dropbox upload web_invtory.csv invtory/web_invtory.csv
dropbox upload dif_stock.csv invtory/ dif_stock.csv
rm dif_stock
rm dif_stock.csv
rm invtory.csv
