#!/bin/bash
###This file is only going to be for getting all the files downloaded and ready
###for the rest of the scripts to work.
### Working forders listed below
### /CDK-Raw
### Web-Raw
dropbox="/home/jeremy/.dropscrit/dropbox_uploader.sh"

##pulling all the working files in to the directroy
$dropbox download invtory/CDK-Raw  working/
$dropbox download invtory/Web-site working/
