#!/usr/bin/perl
use utf8;

require './config.pl';
require 'train_ga_mod_2.pl';

$type = "ham";
$set = 4;
$outfile = "";

# Read image
my $dir = "../pgm/".$type;
my $output = "../features/$set/$type/";
opendir(DIR, $dir);
while(my $file = readdir(DIR)){
	if (not ($file eq "." || $file eq "..")){
		
		print "FILE $file RUN: $dir; TIME: $set (NOI: $NUMBER_OF_INPUT)\n";
		$outfile = $output.$file;
		$IMAGE_ = $dir."/".$file;
		
		&run($IMAGE_, $outfile);

		print "Completed\n";
	}
}

