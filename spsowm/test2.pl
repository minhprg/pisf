#!/usr/bin/perl
use utf8;

require "./config.pl";
require 'train_ga_mod.pl';

$type = "spam";
$set = 2;
$outfile = "";

# Read image
my $dir = "../pgm/".$type;
my $output = "../features/$set/$type/";
opendir(DIR, $dir);
while(my $file = readdir(DIR)){
	if (not ($file eq "." || $file eq "..")){
		
		print "processing $file ";
		$outfile = $output.$file;
		$IMAGE_ = $dir."/".$file;
		
		&run($IMAGE_, $outfile);

		print "completed\n";
	}
}

