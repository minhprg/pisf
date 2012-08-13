#!/usr/bin/perl
use utf8;

require "misc.pl";

sub naiveBayesianClassifer{
	
}

sub learnBayesianThreshold{
	my $set = $TESTCASE; # define SET
	my @vocab = &getAllThreshold($TESTCASE, 2);
	
	for ($i = 0; $i < 2; $i++) {
		my $docs = 50;
		my $PROB_V = 50 / 100;
		my $text_j = &getAllThreshold($TESTCASE, $i);; # get all thresholds
		my @n = &getDistinctThreshold(@vocab); # number of distinct thresholds
		for ($j = 0; $j < scalar(grep {defined $_} @vocab); $j++) {
			my $n_k = &getNK(@text_j, @vocab[$j]); # number of time threshold @vocab[$j] occurs in $text_j
			my $PROB_W = ($n_k + 1) / (scalar(grep {defined $_} @n) + scalar(grep {defined $_} @vocab));
			print $PROB_W;
			if ($j == 0) {
				# save to SPAM @spam_scores ...
				push @SPAM_SCORES, $PROB_W;
			}
			else {
				# save to HAM @ham_scores ...
				push @HAM_SCORES, $PROB_W;
			}
		}
	}
}

sub getDistinctThreshold{
	if ($_[0] eq undef || $_[1] eq undef){
		print "Params required\n";
		return;
	} 
	my @tempThreshold = @_;
	my @result = ();
	my $size = pop @tempThreshold;
	my $tCount;
	my $isDuplicate = true;
	
	while(1){
		my @tSet = ();
		for(0..$size-1){push @tSet, shift @tempThreshold;}
		$tCount = @tempThreshold;
		for(my $i=0; $i<$tCount - $size; $i++){
			$isDuplicate = true;
			for(my $j=0; $j<$size; $j++){
				$i = $i+$j;
				print "loop $j:$i\n";
				if ($tSet[$j] ne $tempThreshold[$i]){
					$i = $i+$size-$j;
					$j = $size;
					$isDuplicate = false;
				}
			}
			if ($isDuplicate eq true){
				$i = $tCount; #end loop because duplicate found.
				print "found\n";
			}
		} 
		if ($isDuplicate eq false){
			print "add\n";
			push @result, @tSet;
		}
		
		last if ($tCount < $size);
	}
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
