#!/usr/bin/perl
use utf8;

require 'helpers.pl';

my $filename = "bmp/spam/2000.jpg";
#can read most of common image format.
#param 0: folder to read.
#param 1 (optional) : folder to write result.
&readFolder('bmp/spam', 'pgm/spam');
