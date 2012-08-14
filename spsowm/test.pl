#!/usr/bin/perl
use utf8;

require './config.pl';
require 'train_ga_mod_2.pl';

$type = "ham";
$set = 1;
$outfile = "";
$count = 0;
system ("/usr/bin/perl init_pop.pl"); #run init pop
my $start_time = time();
# Read image
my $dir = "../pgm/".$type;
my $output = "../features/$set/$type/";
opendir(DIR, $dir);
while(my $file = readdir(DIR)){
	if (not ($file eq "." || $file eq "..")){
		$count++;
		print "FILE($count) $dir/$file; SET: $set (NOI: $NUMBER_OF_INPUT)\n";
		$outfile = $output.$file;
		$IMAGE_ = $dir."/".$file;
		
		&run($IMAGE_, $outfile);

		print "Completed\n";
	}
}

my $time = time() - $start_time;
print "Total time: $time \n";
