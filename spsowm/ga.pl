#************************************************************************
#*                                                                      *
#*   ga.pl, in the package of                                           *
#*                                                                      *
#*   block-based neural network evolved by Genetic Algorithms	        *
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


sub initialization_ga
{
        for (my $i = 0; $i < $POP_SIZE; $i ++)
        {
			for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
			{
				$POPULATION2[$i]->[$k] = 0;
			}
        }
} # end of initialization



sub selection
{

	# sort

	my $a;

        for ($i = 0; $i < $POP_SIZE - 1; $i ++)
        {
                for ($j = $i + 1; $j < $POP_SIZE; $j ++)
		{
                        if ($OBJECTIVE[$i] >= $OBJECTIVE[$j])
                        {

				&copy_chromosome ($POPULATION[$i], \@TEMP);
				&copy_chromosome ($POPULATION[$j], $POPULATION[$i]);
				&copy_chromosome (\@TEMP, $POPULATION[$j]);

                                $a = $OBJECTIVE[$i];
                                $OBJECTIVE[$i] = $OBJECTIVE[$j];
                                $OBJECTIVE[$j] = $a;
                        }
		}
        }

	# save the best chromosome


	if ($BEST_OBJECTIVE >= $OBJECTIVE[0])
	{
		&copy_chromosome ($POPULATION[0], \@BEST_CHROMOSOME);

		$BEST_OBJECTIVE = $OBJECTIVE[0];
	}



	my @q;

        $q[0] = 1;

	my $r;

        my $t = 0.999;
        for (my $i = 1; $i < $POP_SIZE; $i++)
        {
                $t = $t * $t;
                $q[$i] = $q[$i - 1] + $t;
        }

        for ($i = 0; $i < $POP_SIZE; $i ++)
        {
                $r = rand ($q[$POP_SIZE - 1]);

                for (my $j = 0; $j < $POP_SIZE; $j ++)
		{
                        if ($r <= $q[$j])
                        {
				&copy_chromosome ($POPULATION[$j], $POPULATION2[$i]);

                                $OBJECTIVE2[$i] = $OBJECTIVE[$j];

                                last;
                        }
		}
        }

        for ($i = 0; $i < $POP_SIZE; $i ++)
        {
		&copy_chromosome ($POPULATION2[$i], $POPULATION[$i]);

                $OBJECTIVE[$i] = $OBJECTIVE2[$i];

        }
}







sub crossover
{
	my ($point_r, $point_c);

	my ($bit);

	for (my $i = 0; $i < $POP_SIZE; $i ++)
	{
		for (my $j = $i + 1; $j < $POP_SIZE; $j ++)
		{
			next if (rand () > $P_CROSSOVER);

			&copy_chromosome ($POPULATION[$i], $POPULATION2[$i]);
                	$OBJECTIVE2[$i] = $OBJECTIVE[$i];
			&copy_chromosome ($POPULATION[$j], $POPULATION2[$j]);
                	$OBJECTIVE2[$j] = $OBJECTIVE[$j];



			$point_c = int (rand ($NUMBER_OF_INPUT));

                        for (my $l = $point_c; $l < $NUMBER_OF_INPUT; $l ++)
                        {
                                $bit = $POPULATION[$i]->[$l];
                                $POPULATION[$i]->[$l] = $POPULATION[$j]->[$l];
                                $POPULATION[$j]->[$l] = $bit;
                        }

			$point_c = int (rand ($NUMBER_OF_INPUT));

                        for (my $l = $point_c; $l < $NUMBER_OF_INPUT; $l ++)
                        {
                                $bit = $POPULATION[$i]->[$l];
                                $POPULATION[$i]->[$l] = $POPULATION[$j]->[$l];
                                $POPULATION[$j]->[$l] = $bit;
                        }

			$OBJECTIVE[$i] = 10000000000;
			$OBJECTIVE[$j] = 10000000000;

			if (! &in_the_range ($POPULATION[$i]) || ! &in_the_range ($POPULATION[$j]))
                	{
				&copy_chromosome ($POPULATION2[$i], $POPULATION[$i]);
                		$OBJECTIVE[$i] = $OBJECTIVE2[$i];
				&copy_chromosome ($POPULATION2[$j], $POPULATION[$j]);
                		$OBJECTIVE[$j] = $OBJECTIVE2[$j];
			}
		}
	} 
}



sub mutation
{
        for (my $i = 0; $i < $POP_SIZE; $i ++)
        {

		&copy_chromosome ($POPULATION[$i], $POPULATION2[$i]);
                $OBJECTIVE2[$i] = $OBJECTIVE[$i];

               	for (my $l = 0; $l < $NUMBER_OF_INPUT; $l ++)
                {
			next if (rand () > $P_MUTATION);

			if ($l == 0)
                        {
                                $PARA_MIN = 0;
                                $PARA_MAX = $POPULATION[$i]->[$l + 1];

                        } elsif ($l == $NUMBER_OF_INPUT - 1)
                        {
                                $PARA_MIN = $POPULATION[$i]->[$l - 1];
                                $PARA_MAX = $GREY_MAX;
                        } else
                        {
                                $PARA_MIN = $POPULATION[$i]->[$l - 1];
                                $PARA_MAX = $POPULATION[$i]->[$l + 1];
                        }

			$POPULATION[$i]->[$l] = $PARA_MIN + int (rand ($PARA_MAX - $PARA_MIN));


			$OBJECTIVE[$i] = 10000000000;
                }

		if (! &in_the_range ($POPULATION[$i]))
		{
			&copy_chromosome ($POPULATION2[$i], $POPULATION[$i]);
                	$OBJECTIVE[$i] = $OBJECTIVE2[$i];
		}

	}
}



1;
