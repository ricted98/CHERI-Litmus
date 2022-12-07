#!/bin/bash

echo $1

for FILE in $(find $1 -name "*.litmus")
do
	rm -f tmp.txt

	head -n -1 $FILE > tmp.txt
	tail -1 $FILE | tail -1 | sed 's/;/=0 \/\\ /g' >> tmp.txt
	cat tmp.txt > $FILE

done