#!/bin/bash

provs=('Ontario' 'Quebec' 'Alberta' 'Saskatchewan' 'BC')

for province in ${provs[@]}
do

if [ $province == 'Alberta' ];
then
  echo 'Alberta is the best'
else
  echo "I'm not a fan"
fi

done