#!/bin/bash

#rm ./cmp_result/*

for (( i = 0; i < 50; i++ )) 
do
	perl train_pso.pl > ./cmp_result/hpsowm_result_$i
	perl train_ga.pl > ./cmp_result/ga_result_$i

#	sleep 1
done
