#!/bin/bash
# Computes average score on traces!

files=(fp_1.bz2 fp_2.bz2 int_1.bz2 int_2.bz2 mm_1.bz2 mm_2.bz2)
# static, gshare, tournament, custom
predictors=(gshare)

make clean
make

for predictor in ${predictors[@]}
do
    sum=0
    for file in ${files[@]}
    do
        cur_num=$(bunzip2 -kc ../traces/${file} | ./predictor --${predictor} | grep "Misprediction Rate:" | awk -F ' ' '{print $3}')
        sum=$(echo "$sum + $cur_num" | bc)
    done
    avg=$(echo "scale=3; $sum / 6" | bc)
    echo $predictor " Avg:" $avg
done
