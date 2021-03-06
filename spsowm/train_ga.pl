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

$start_time = time ();

require "./config.pl";
require "./misc.pl";
require "./ga.pl";
require "./entropy.pl";

# Global variables

@POPULATION;
@POPULATION2;
@OBJECTIVE;
@OBJECTIVE2;
@TEMP;
@BEST_CHROMOSOME; # store the best result
$BEST_OBJECTIVE = 10000000000;


# Global variables for Entropy
@GREY_MAX;
@PROP_I;

$save_best_obj = 100;

$|=1;

srand (time ^ $$ ^ unpack "%L*", `ps axww | gzip -f`);

# Initiate a population

&restore_population ();

&initialization_ga ();

#if ($ARGV[0])
#{
#	&read_chromosome ($POPULATION[0]);
#}

$IMAGE = "../pgm/spam/31.pgm";
# Read image
&read_image ($IMAGE);


$iter = 0;

while (1)
{
        $iter ++;

#	&evaluation ();
#	&evaluation_manhattan ();

	&evaluation_image ();


	&selection ();
	&mutation ();
	&crossover ();

# Remain the best chromosome in the population

	&copy_chromosome (\@BEST_CHROMOSOME, $POPULATION[0]);
       $OBJECTIVE[0] = $BEST_OBJECTIVE;

        $time = time () - $start_time;


	if ($BEST_OBJECTIVE < $save_best_obj)
	{
		&print_chromosome (\@BEST_CHROMOSOME);

		$save_best_obj = $BEST_OBJECTIVE;
        print $time." ".$iter." ".$BEST_OBJECTIVE."\n";

	}

        #print $time." ".$iter." ".$BEST_OBJECTIVE."\n";

        last if ($time > $MAX_TIME);

	last if ($BEST_OBJECTIVE <= $OPTIMAL);
}
