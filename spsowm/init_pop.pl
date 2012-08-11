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
require "./misc.pl";


# Global variables

@POPULATION;
@POPULATION2;
@OBJECTIVE;
@OBJECTIVE2;
@TEMP;
@BEST_CHROMOSOME; # store the best result
$BEST_OBJECTIVE;

# Global variables for PSO
@P_BEST_CHROMOSOME; # store the gbest result
$P_BEST_OBJECTIVE;
@G_BEST_CHROMOSOME; # store the gbest result
$G_BEST_OBJECTIVE;

@VELOCITY;

$|=1;

srand (time ^ $$ ^ unpack "%L*", `ps axww | gzip -f`);

# Initiate a population

&initialization ();

#&restore_population ();

&store_population ();
