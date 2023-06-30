#!/bin/bash

[ -z "$MCMP7" ] && MCMP7="mcompare7"

model_result=model-results/herd.logs
hw_result=../../litmus.log

$MCMP7 -nohash $hw_result $model_result
