#!/bin/sh

#searches for special characters and replaces with their URL ASCII equivalents

#read input from line
echo enter command string
read input

#create output textfile
touch out.txt
#sed search + replace
echo $input | sed 's/\s/%20/g' | sed 's/\+/%2B/g' | sed 's/\-/%2D/g' | sed 's/\;/%3B/g' | sed 's/\./%2E/g' | sed 's/\//%2F/g' | sed 's/:/%3A/g' > subs.txt

cat subs.txt
