#!/usr/bin/perl

use utf8;

print "Hello, world!\n";

@lines = `perldoc -u -f atan2`; 
foreach (@lines) {
	s/\w<([^>]+)>/\U$1/g;
	print; 
}