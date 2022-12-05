#!/bin/bash

list=$(tail -1 /scratch/msc22h2/CHERI-Litmus/log/log.txt)
files=( $list )
for i in $(seq 5 1 ${#files[@]})
do
	filename=$(echo "${files[i]}.litmus" | cut -c 2-)
	find /scratch/msc22h2/CHERI-Litmus/tests/riscv-tests/non-mixed-size -name $filename
done

