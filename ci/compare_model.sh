#!/bin/bash

model_result=../litmus-tests-riscv/model-results/herd.logs
hw_result=run.log

mcompare7 -nohash $hw_result $model_result