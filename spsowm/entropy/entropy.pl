

	open FP, "< lena.pgm";

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

	$i = 1;

	while ($line = <FP>)
	{
		chop $line;
		$line =~ s/[^\d]+$//;

		my @a = split /\s+/, $line;

		foreach (@a)
		{
			print $_." ";
			$i ++;

			if ($i > $nn)
			{
				$i = 1;
				print "\n";
			}
		}
	}

	close FP;

