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

#you'll need to make a bed file indicating starting and end positin, and run pixy on seperate chromosome/contig. The new version of pixy might have this problem fixed. 
pixy --stats fst \
	--vcf allsites_filtered.vcf.gz \
	--populations fst_pop.txt \ #target pop and reference pop. See example file <fst_pop.txt>
	--window_size 20000 \
	--interval_start ${startpos} \
	--interval_end ${endpos} \
         --output_folder results/ \
	--output_prefix fst_SKvs75DC


#change pop accordingly
pixy --stats pi \
	--vcf allsites_filtered.vcf.gz \
	--populations pi_pop.txt \ #target pop . See example file <pi_pop.txt>
	--window_size 20000 \
	--interval_start ${startpos} \
	--interval_end ${endpos} \
         --output_folder results/ \
	--output_prefix pi_$pop



conda deactivate
module purge
