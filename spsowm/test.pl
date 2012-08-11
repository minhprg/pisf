#!/usr/bin/perl

#************************************************************************
#*                                                                      *
#*   bbnn.pl                                                            *
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

require "./config.pl";
require "./configuration.pl";
require "./ga.pl";
require "./bbnn.pl";
require "./misc.pl";
require "./data_test.pl";


# Global variables

@POPULATION;
@POPULATION2;
@OBJECTIVE;
@OBJECTIVE2;
@TEMP;
@BEST_CHROMOSOME; # store the best result
$BEST_OBJECTIVE;


for (my $thres = -10; $thres <= 10; $thres ++)
{

	next if ($thres != 0); # just compute when $thres = 0 for comparison


	my $num = scalar (@DATA);

	my $accuracy = 0;

	for (my $j = 0; $j < $num; $j ++)
	{
       		my $string = "";

		my @u;

		my $label;

       		for (my $k = 0; $k < $NUMBER_OF_INPUT; $k ++)
       		{
               		$u[$k] = $DATA[$j]->[$k];

			$string .= $DATA[$j]->[$k];

       		}

        	if ($hash_save{"$string"})
        	{
                	$label = $hash_save{"$string"} - 10;
        	} else
		{
       			@output = &iterative_chromosome (\@CONFIGURATION, @u);

       			$label = $output[$NUMBER_OF_INPUT - 1];

        		$hash_save{"$string"} = $label + 10;
		}

		$obj += abs ($label - $DATA[$j]->[$NUMBER_OF_INPUT]) / 2;

	}

	my $obj = int (10000 * $obj / $num + 0.555555) / 10000;

	print "$obj\n";

}
