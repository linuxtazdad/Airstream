#!/bin/bash
#testing if an if else is going to work for what I needed it to or not.
for i in $(cat Working/CDK-Raw/CDK-All-Store.csv) ;do
  COMPANY_NUMBER=$(echo $i |cut -d ',' -f16)
#  if $COMPANY_NUMBER=14
#  then
#    LOCATED=AIE
#  elif [[ $COMPANY_NUMBER=15 ]]; then
#    LOCATED=ALA
#  elif [[ $COMPANY_NUMBER=16 ]]; then
#    LOCATED=AOC
#  else
#    LOCATED=ALV
#  fi
case $COMPANY_NUMBER in
  14 )
  LOCATED=AIE
    ;;
  15 )
  LOCATED=ALA
    ;;
  16 )
  LOCATED=AOC
    ;;
  26 )
  LOCATED=ALV
    ;;
esac


echo $LOCATED
done
