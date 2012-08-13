#!/usr/bin/perl
use utf8;
use Image::BMP;

sub naiveBayesianClassifer {
	
}

sub getDistinctThreshold{
	 my @unique = grep { ! $Seen{ $elem }++ } @_;
	 return @unique;
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
