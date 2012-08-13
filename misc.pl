#!/usr/bin/perl
sub getNK {
	my ($set, $t) = $_;
	my $c = 0;
	foreach $item (@set) {
		if ($item == $t) {
			$c += 1;
		}
	}
	return $c;
}

1;