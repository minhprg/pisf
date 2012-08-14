#!/usr/bin/perl
sub getNK {
	my @set = $_[0];
	my $t = $_[1];
	my $c = 0;
	print $_[3]."\n";
	foreach $item (@set) {
		if ($item == $t) {
			$c += 1;
		}
	}
	return $c;
}

1;