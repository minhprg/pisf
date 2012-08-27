#!/usr/bin/perl
use utf8;

$type = "spam";
$set = 1;
$outfile = "";

# Read image
my $dir = "pgm/".$type;
my $output = "features/$set/$type/";
opendir(DIR, $dir);
while(my $file = readdir(DIR)){
	if (not ($file eq "." || $file eq "..")){
		
		print "processing $file ";
		$outfile = $output.$file;
		$IMAGE_ = $dir."/".$file;
		
		system("/usr/bin/perl spsowm/train_ga_mod_2.pl");

		print "completed\n";
	}
}

