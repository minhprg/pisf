#!/usr/bin/perl
use utf8;
use List::MoreUtils qw/ uniq /;

require "misc.pl";

sub naiveBayesianClassifer{
	my $type = $_[0];
	print "Start testing... with type $type \n";
	sleep (2);
	
	my $correct_rate = 0;
	
	for ($i = 1; $i <= $DATA_SIZE; $i++) {
		my $spam;
		my $ham;
		for ($j = 0; $j < 2; $j++) {
			@img = getOneImage($j, $i, $TESTCASE);
			#@img = getDistinctThreshold(@img);
			my $vnb = log($PROB_V);
			foreach $t (@img) {
				if ($type eq 0) {
					$score = @SPAM_SCORES[$t - 1];
					#print "$score\n";
				}
				else {
					$score = @HAM_SCORES[$t - 1];
					#print "$score\n";
				}
				$vnb = $vnb + log($score);
			}
			
			if ($j eq 0) { # save score to spam
				$spam = $vnb;
			}
			else {
				$ham = $vnb;
			}
		}
		
		if ($type eq 0) {
			if ($spam > $ham) {
				$correct_rate = $correct_rate + 1;
				#print "Correct rate: $correct_rate / 52 \n";
			}
		}
		else {
			if ($ham > $spam) {
				$correct_rate = $correct_rate + 1;
				#print "Correct rate: $correct_rate / 52 \n";
			}
		}
	}
	print "OVERALL: ". ($correct_rate / $DATA_SIZE * 100). "% \n"; 
}

sub learnBayesianThreshold{
	my $set = $TESTCASE; # define SET
	my @vocab = &getVocabulary;
	
	for ($i = 0; $i < 2; $i++) {
		my $docs = $DATA_SIZE;
		my $PROB_V = 0.5;
		my @text_j =  getTextJ($i); # get all thresholds by class
		my @n = &getDistinctThreshold(@text_j); # number of distinct thresholds
		for ($j = 0; $j < 256; $j++) {
			my $n_k = 0; # number of time threshold @vocab[$j] occurs in $text_j
			my $k = 0;
			foreach $item (@text_j) {
				if ($item eq $j) {
					$n_k = $n_k + 1;
					$k = $k + 1;
				}
			}
			
			my $PROB_W = ($n_k + 1) / (scalar(@n) + scalar(@vocab));
			#print "$i. Working with color: $j . Score = $PROB_W \n";
			if ($i == 0) {
				# save to SPAM @spam_scores ...
				push @SPAM_SCORES, $PROB_W;
			}
			else {
				# save to HAM @ham_scores ...
				push @HAM_SCORES, $PROB_W;
			}
		}
	}
	
	print "Training done! Now start to test...\n";
}

sub getDistinctThreshold{
	my @result = uniq @_;
}

# Get all gray-scale color code of ALL Images
sub getVocabulary {
	my @vocab = ();
	
	push @vocab, &getTextJ(0);
	push @vocab, &getTextJ(1);
	return @vocab;
}

# Get gray-scale color code of ONE SPAM OR HAM - 0 = SPAM. 1 = HAM
sub getTextJ {
	my $dir = "pgm/spam/";
	if ($_[0] eq 1) { $dir = "pgm/ham/";}
	
	my @result = ();
	#read each file in the directory
	opendir (DIR, $dir) or die ("Unable to open $dir\n");
	while (my $f = readdir(DIR)){
		open(FILE, $dir.$f);
		#ignore the first 3 lines.
		my $line = <FILE>;
		$line 	 = <FILE>;
		$line 	 = <FILE>;
		$line 	 = <FILE>;
		chop $line;
		$line =~ s/[^\d]+$//;
		my @a = split /\s+/, $line;
		push @result, @a;
	}
	return @result;
}

sub getOneImage {
	my $type = $_[0];
	my $index = $_[1];
	my $set = $_[2];
	
	my $dir = "features/$set/spam/";
	if ($_[0] eq 1) { $dir = "features/$set/ham/";}
	
	my @result = ();
	#read each file in the directory
	opendir (DIR, $dir) or die ("Unable to open $dir\n");
	open(FILE, $dir.$index.".pgm.txt");
	#ignore the first 3 lines.
	my $line = <FILE>;
	chop $line;
	$line =~ s/[^\d]+$//;
	my @a = split /\s+/, $line;
	push @result, @a;
	return @result;
}



sub getDistinctThreshold{
	my @result = uniq @_;
	return @result;
}

#type: 0 -> read spam, 1 -> get ham, 2 => get all. default 0;
sub getAllThreshold{
	my @threshold = ();
	
	if ($_[0] eq undef)
	{
		print "Param required.\n"; return;
	}
	my ($set, $type) = @_;
	#read every file in spam folder.
	if ($type eq 0 or $type eq 2)
	{
		my $dir = "features/$set/spam/";
		opendir (SPAM, $dir);
		while(my $s = readdir(SPAM))
		{
			open(FILE, $dir.$s);
			my $line = <FILE>;
			chop $line;
			$line =~ s/[^\d]+$//;
			my @a = split /\s+/, $line;
			push @threshold, @a;
		}
	}
	
	if ($type eq 1 or $type eq 2)
	{
		my $dir = "features/$set/ham/";
		opendir (SPAM, $dir);
		while(my $s = readdir(SPAM))
		{
			open(FILE, $dir.$s);
			my $line = <FILE>;
			chop $line;
			$line =~ s/[^\d]+$//;
			my @a = split /\s+/, $line;
			push @threshold, @a;
		}
	}
	return @threshold;
}

sub helloWorld {
	print 'Hello Sub routines!\n';
}

return true;
