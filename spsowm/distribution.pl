while (<>)
{
	chop $_;

	@data = split (/ /, $_);

	foreach (@data)
	{
		$hash{"$_"} ++;
	}
}


#$key = -100;

foreach $value ( sort {$hash{$a} <=> $hash{$b}} keys %hash)
{
	print $value." ".$hash{"$value"}."\n";

#	print $value." ".($key / 100)."\n";
#
#	if ($key < 0)
#	{
#		$key = -1 * $key - 2;
#	} else
#	{
#		$key = -1 * $key + 2;
#	}
}

