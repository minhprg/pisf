#!/usr/bin/perl

require "algorithms.pl";

use utf8;

print "Hello, world!\n";

&helloWorld();

@lines = `perldoc -u -f atan2`; 
foreach (@lines) {
	s/\w<([^>]+)>/\U$1/g;
	#print; 
}