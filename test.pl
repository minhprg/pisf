#!/usr/bin/perl
use utf8;
use Image::BMP;

require "algorithms.pl";

#param 0: set[1 or 2 or 3 or 4]
#param 1: 0 => get spam, 1 => get ham, 2 => get all.
@ts = &getAllThreshold(1, 0);

foreach $t (@ts){
	#foreach $i (@t){print "$i ";}
	print "$t\n";
}
