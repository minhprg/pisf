#!/usr/bin/perl
use utf8;
use Image::BMP;

require "algorithms.pl";

#param 0: set[1 or 2 or 3 or 4]
#param 1: 0 => get spam, 1 => get ham, 2 => get all.
#@a = (1,2,3,4,5);
#@ts = (2,1,2,3,4);
#for (0..4){
#	push @ts, @a;
#}
#@out = &getDistinctThreshold(@ts, 5);
#print "@ts\n@out\n";
@a = &getAllThreshold(4, 1);
foreach $t (@a){print "$t ";}

