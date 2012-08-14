#!/usr/bin/perl

require "algorithms.pl";
require "misc.pl";
use List::MoreUtils qw/ uniq /;

use utf8;

@SPAM_SCORES = ();
@HAM_SCORES = ();
$TESTCASE = 1;

learnBayesianThreshold();



my @arr = &getAllThreshold($TESTCASE, 1);
my @b = &getDistinctThreshold(@arr);
foreach $t (@b){



my @arr = &getAllThreshold($TESTCASE, 2);
my @b = &getDistinctThreshold(@arr);
my @c = uniq @SPAM_SCORES;
foreach $t(@c){
	print "$t \n";
}
1;
