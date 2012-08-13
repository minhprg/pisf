#!/usr/bin/perl

require "algorithms.pl";
require "misc.pl";

use utf8;

@SPAM_SCORES;
@HAM_SCORES;
$TESTCASE = 1;

learnBayesianThreshold();

print &getAllThreshold($TESTCASE, 1);

1;