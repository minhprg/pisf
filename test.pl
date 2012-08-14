#!/usr/bin/perl
use utf8;
use Image::BMP;

require "helpers.pl";

my $start_time = time();
&readFolder("bmp/spam");
my $time = time() - $start_time;
print "Time: $time\n";


