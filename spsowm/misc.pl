#************************************************************************
#*                                                                      *
#*   misc.pl, in the package of                                         *
#*                                                                      *
#*   block-based neural network evolved by Genetic Algorithms           *
#*                                              			* 
#*   an implementation of the following paper				*
#*									*
#*      S.W. Moon, S.G. Kong, "Block-Based Neural Networks,"		*
#*      IEEE Transactions on Neural Networks,				*
#*      Vol 12, No 2, March, 2001, pp. 307-317				*
#*									*
#*   Author: Tran Quang Anh                                             *
#*   Date: July, 2011                                                   *
#*                                                                      *
#*   Copyright (c) 2011  Tran Quang Anh - All rights reserved           *
#*                                                                      *
#*   This software is available for non-commercial use only. It must    *
#*   not be modified and distributed without prior permission of the    *
#*   author. The author is not responsible for implications from the    *
#*   use of this software.                                              *
#*                                                                      *
#************************************************************************

sub initialization
{
        for (my $i = 0; $i < $POP_SIZE; $i ++)
        {
		my @a;

		while (1)
		{
                	for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
                	{
				my $t;

				while (1)
				{
					$t = &my_rand ();

					my $flag = 1;

					foreach my $tt (@a)
					{
						$flag = 0 if ($tt == $t);
					}

					last if ($flag);
				}

				$a[$k] = $t;
			}

			my @b = sort {$a <=> $b} @a;

                	for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
                	{

                        	$POPULATION[$i]->[$k] = $b[$k];
               		}
			
			last if (&in_the_range ($POPULATION[$i]));
		}

		$OBJECTIVE[$i] = 10000000000;
        }
} # end of initialization


sub in_the_range
{
	my ($chr) = @_;

        for (my $i = 0; $i < $NUMBER_OF_INPUT; $i ++)
        {
		my $x = $chr->[$i];

		return 0 if ($x > $X_MAX || $x < $X_MIN);

		if ($i < $NUMBER_OF_INPUT - 1)
		{
			my $y = $chr->[$i + 1];

			return 0 if ($x >= $y);
		}
        }

	return 1;
}

sub copy_chromosome
{
	my ($chr1, $chr2) = @_;

        for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
        {
              	$chr2->[$k] = $chr1->[$k];
        }
}


sub cmp_chromosome
{
        my ($chr1, $chr2) = @_;

        for (my $k = 0; $k < ($NUMBER_OF_INPUT * (3 * $WEIGHT_BIT + 1)); $k ++)
        {
                return 0 if ($chr2->[$k] != $chr1->[$k]);
        }

	return 1;
}

sub display_chromosome
{
	my ($ch) = @_;

	for (my $k = 0; $k < $NUMBER_OF_INPUT - 1; $k ++)
	{
		print $ch->[$k]." ";

	}

	print $ch->[$NUMBER_OF_INPUT - 1];
		
	print "\n\n";
}


sub store_population
{
	open SP_FP, "> ./population_store";

	for (my $i = 0; $i < $POP_SIZE; $i ++)
	{
		print SP_FP $OBJECTIVE[$i]."\n";

		for (my $k = 0; $k < $NUMBER_OF_INPUT - 1; $k ++)
		{
			print SP_FP $POPULATION[$i]->[$k]." ";
		}

		print SP_FP $POPULATION[$i]->[$NUMBER_OF_INPUT - 1];

		print SP_FP "\n\n";
	}

	close SP_FP;
}

sub print_chromosome
{
	my ($ch) = @_;

	open PC_FP, "> ./configuration.pl";

	print PC_FP '@CONFIGURATION = ('."\n";


	for (my $k = 0; $k < $NUMBER_OF_INPUT - 1; $k ++)
	{
		print PC_FP $ch->[$k].", ";

	}		

	print PC_FP $ch->[$NUMBER_OF_INPUT - 1];

	print PC_FP ');';

	close PC_FP;
}


sub restore_population
{
	open RP_FP, "< ./population_store";

	for (my $i = 0; $i < $POP_SIZE; $i ++)
	{
		my $line = <RP_FP>;

		chop $line;

		$OBJECTIVE[$i] = $line;

		my $line = <RP_FP>;

		chop $line;

		my @ft = split (/ /, $line);

		for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
		{
			$POPULATION[$i]->[$k] = $ft[$k];

		}

		my $line = <RP_FP>;
	}

	close RP_FP;
}


sub read_chromosome
{
	open RC_FP, "< ./configuration.pl";

	my $line = <RC_FP>;

	my $line = <RC_FP>;

	chop $line;

	$line =~ s/^\(|\);$//g;

	my @ft = split /, /, $line;

	for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
	{
		$POPULATION[0]->[$k] = $ft[$k];

	}		

	close RC_FP;
}


sub my_rand
{
	return $X_MIN + int (rand ($X_MAX - $X_MIN));
}



sub my_sigmoid
{
        my ($t) = @_;

       # return (2 / (1 + exp (0 - $t)) - 1);

        return 1 / (1 + exp (- $t));
}

sub my_binary_activate
{
        my ($t) = @_;

	$t = 1 if ($t > 1);

	$t = 0 if ($t < 0);

	if (rand () > $t)
	{
		return 0;
	} else
	{
		return 1;
	}
}


sub evaluation
{
	my @output;

	my $num = scalar (@DATA);

	my $a;

	my @u;


	for (my $i = 0; $i < $POP_SIZE; $i ++)
	{

		next if ($OBJECTIVE[$i] != 10000000000); # old chromosome

		my $normal_num = 0;

		my $anom_num = 0;
	
		my $obj = 0;

		my $false_alarm = 0;

		my $detection_rate = 0;

		for (my $j = 0; $j < $num; $j ++)
		{

			my $label;

			for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
			{
				$u[$k] = $DATA[$j]->[$k];
			}

			@output = &iterative_chromosome ($POPULATION[$i], @u);

			if ($output[0] == -1000)
			{
				$obj = -1;
				last;
			} 

			if ($output[$NUMBER_OF_INPUT - 1] > $THRESHOLD)
			{
				$label = 1;
			} else
			{
				$label = -1;
			}

		
			if ($DATA[$j]->[$NUMBER_OF_INPUT] == 1)
			{
				$anom_num ++;

				if ($label == 1)
				{
					$obj ++;
					
					$detection_rate ++;
				}

			} else
			{
				$normal_num ++;

				if ($label == -1)
				{
					$obj ++;
				} else
				{
					$false_alarm ++;
				}
			}
		}


		$obj = -1 if ($obj != -1 && $false_alarm / $normal_num > $E_FALSE_ALARM);

		if ($obj != -1)
		{
			$OBJECTIVE[$i] = $detection_rate /$anom_num;
			#$OBJECTIVE[$i] = $obj /$num;
		} else
		{
			$OBJECTIVE[$i] = -1;
		}

	}

} # end of evaluation

sub evaluation_manhattan
{
	my @output;

	my $num = scalar (@DATA);

	my @u;


	for (my $i = 0; $i < $POP_SIZE; $i ++)
	{

		next if ($OBJECTIVE[$i] != 10000000000); # old chromosome

		my $obj = 0;

		for (my $j = 0; $j < $num; $j ++)
		{

			my $label;

			for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
			{
				$u[$k] = $DATA[$j]->[$k];
			}

			@output = &iterative_chromosome ($POPULATION[$i], @u);

			if ($output[0] == -1000)
			{
				$obj = 1000;
				last;
			} 

		
			$obj += abs ($output[$NUMBER_OF_INPUT - 1] - $DATA[$j]->[$NUMBER_OF_INPUT]) / 2;
		}

		$OBJECTIVE[$i] = $obj / $num;

	}

} # end of evaluation


sub evaluation_image
{
	for (my $i = 0; $i < $POP_SIZE; $i ++)
	{

		next if ($OBJECTIVE[$i] != 10000000000); # old chromosome

		my @u = ();

		for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
		{
			$u[$k] = $POPULATION[$i]->[$k];
		}

		$OBJECTIVE[$i] = - (&entropy (@u));

	}

}

sub evaluation_benchmark
{
	my $output;

	for (my $i = 0; $i < $POP_SIZE; $i ++)
	{
		next if ($OBJECTIVE[$i] != 10000000000); # old chromosome

		if ($B_F == 1)
		{
			$output = &benchmark_f1 ($POPULATION[$i]);

		} elsif ($B_F == 6)
		{
			$output = &benchmark_f6 ($POPULATION[$i]);
		} elsif ($B_F == 12)
		{
			$output = &benchmark_f12 ($POPULATION[$i]);
		} elsif ($B_F == 14)
		{
			$output = &benchmark_f14 ($POPULATION[$i]);
		} elsif ($B_F == 15)
		{
			$output = &benchmark_f15 ($POPULATION[$i]);
		}

		$OBJECTIVE[$i] = $output;

	}

} # end of evaluation
1;
