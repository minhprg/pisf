#!/usr/bin/perl
use utf8;
use Image::BMP;

require "algorithms.pl";

#param 0: set[1 or 2 or 3 or 4]
#param 1: 0 => get spam, 1 => get ham, 2 => get all.
@ts = &getAllThreshold(1, 0);
my @test = ();
my @arr = (12, 23,24, 21, 12);

for(my $i = 0; $i < 4; $i++){
	push @test, [@arr];
}
@distinct = &getDistinctThreshold(@test);

foreach $t (@distinct){
	#foreach $i (@t){print "$i ";}
	print "row: ";
	for (my $i=0; $i<5; $i++){
		print $t->[$i]." ";
	}
	print "\n";
}
