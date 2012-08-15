#!/usr/bin/perl

require "algorithms.pl";
require "misc.pl";
use List::MoreUtils qw/ uniq /;

use utf8;

@SPAM_SCORES = ();
@HAM_SCORES = ();
$TESTCASE = 1;
$PROB_V = 0.05376344;
$DATA_SIZE = 51;

@r = getOneImage(0,1,$TESTCASE);
foreach $t (@r) {
	print "$t \n";
}

learnBayesianThreshold();

naiveBayesianClassifer(0);
#naiveBayesianClassifer(1);

1;
