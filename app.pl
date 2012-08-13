#!/usr/bin/perl

require "algorithms.pl";
require "misc.pl";

use utf8;

@SPAM_SCORES;
@HAM_SCORES;
$TESTCASE = 1;

learnBayesianThreshold();



my @arr = &getAllThreshold($TESTCASE, 1);
my @b = &getDistinctThreshold(@arr);
foreach $t (@b){
	print "$t \n";
}
1;
