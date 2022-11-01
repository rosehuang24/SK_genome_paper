#!/bin/bash

source ~/.bash_profile
module load plink/1.90

plink --vcf $SNPVCF --chr-set 28 no-x no-y no-xy --recode --out <input>

plink --file <input> --chr-set 28 no-x no-y no-xy --homozyg-density 5000 --homozyg-kb 100 --homozyg-snp 33 --out $OUTDIR/input.roh_customized_para
