
sub read_image
{
	my ($image) = @_;

	open FP, "< $image";

	$line = <FP>;
	$line = <FP>;

	$line = <FP>;
	chop $line;
	$line =~ s/[^\d]+$//;

	my ($mm, $nn) = split /\s+/, $line; # mm * nn

	$line = <FP>;
	chop $line;
	$line =~ s/[^\d]+$//;

	$GREY_MAX = $line;

	$X_MAX = $GREY_MAX;

	my %hash_p;

	while ($line = <FP>)
	{
		chop $line;
		$line =~ s/[^\d]+$//;

		my @a = split /\s+/, $line;

		foreach (@a)
		{
			$hash_p{$_} ++;
		}
	}

	for (my $i = 0; $i <= $GREY_MAX; $i ++)
	{
		$PROB_I[$i] = $hash_p{$i} / ($mm * $nn);
	}

	close FP;

}




sub entropy
{
	my @tt = @_;

	push @tt, $GREY_MAX;

	my $num = @tt;

	my $ent = 0;

	my $ppp = 0;

	for (my $i = 0; $i <= $tt[0]; $i ++)
	{
		$ppp += $PROB_I[$i];
	}

	if ($ppp != 0)
	{

		for (my $i = 0; $i <= $tt[0]; $i ++)
		{
			my $a = ($PROB_I[$i] / $ppp);

			if ($a != 0)
			{
				$ent += (- $a * log ($a));
			}
		}
	}

	for (my $j = 0; $j < $num - 1; $j ++)
	{
		my $ppp = 0;

		for (my $i = $tt[$j] + 1; $i <= $tt[$j + 1]; $i ++)
		{
			$ppp += $PROB_I[$i];
		}

		if ($ppp != 0)
		{

			for (my $i = $tt[$j] + 1; $i <= $tt[$j + 1]; $i ++)
			{
				my $a = ($PROB_I[$i] / $ppp);

				if ($a != 0)
				{
					$ent += (- $a * log ($a));
				}
			}
		}
	}

	return $ent;
}

1;
