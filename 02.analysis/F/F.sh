#!/bin/bash
source ~/.bash_profile

module load vcftools/0.1.16

vcftools --gzvcf <SNPVCF> --exclude-bed $REFDIR/galGal6.masked.bed --het --out vt.het.exclude_repeat
