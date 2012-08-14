#!/usr/bin/perl
use utf8;
use Image::BMP;

require "algorithms.pl";

@arr = &getVocabulary();
$c = @arr;
print "@arr\n";

