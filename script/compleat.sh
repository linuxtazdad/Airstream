#//this is just a easy way to get it all taken care of.
alias dropbox="/home/jeremy/.dropscrit/dropbox_uploader.sh"
echo "running  Links.sh"
./Links.sh
echo "getting invtory from dropbox"
/home/jeremy/.dropscrit/./dropbox_uploader.sh download invtory/invtory.csv
echo "comparing the files"
./compare.sh
echo "uploading web invtory to dropbox"
/home/jeremy/.dropscrit/./dropbox_upload.sh upload web_invtory.csv invtory/web_invtory.csv
echo "uploading dif stock to dropbox"
/home/jeremy/.dropscrit/./dropbox_upload.sh upload dif_stock.csv invtory/ dif_stock.csv
echo "would be removing files" 
#rm dif_stock
#rm dif_stock.csv
#rm invtory.csv
#alias dropbox="/home/jeremy/.dropscrit/dropbox_uploader.sh"
