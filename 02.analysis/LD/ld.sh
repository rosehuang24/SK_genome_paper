#!/bin/bash

source ~/.bash_profile


$popdecay/PopLDdecay -InVCF $SNPVCF -MAF 0.05 -OutType 1 -MaxDist 50 -SubPop $TXTDIR/$pop.popline.txt -OutStat LD/ldgraph.107.input.4.50kb.$pop
