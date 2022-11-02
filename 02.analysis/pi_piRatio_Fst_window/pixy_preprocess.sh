#!/bin/bash

module load anaconda3
conda activate pixy


# The GVCF file must contain information for all positions

vcftools --gzvcf <your_input_vcf> \
         --exclude-bed $REFDIR/galGal6.masked.bed \
         --max-maf 0 --minQ 30 --remove-indels --max-missing 0.5 --min-meanDP 10  \
         --recode --recode-INFO-all --stdout | bgzip -c > snp_invariants.vcf.gz

tabix snp_invariants.vcf.gz


#make sure individuals in both file are the same 
#here the variants vcf are the one in the main paper. See /01.SNP_calling/ folder

bcftools concat --allow-overlaps \
          snp_invariants.vcf.gz snp_variants.vcf.gz \
          -O v -o allsites_filtered.vcf
          
          
bgzip allsites_filtered.vcf
tabix allsites_filtered.vcf.gz

