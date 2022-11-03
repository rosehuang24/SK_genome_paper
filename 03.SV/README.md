# SV_calling_and_analysis

## 1. Input Preperation

Bam file: sorted, indexed with read group and indexed. I used dedup.bam

## 2. Methods

Lumpy: https://github.com/arq5x/lumpy-sv.git

lumpy_preprocess.sh 

lumpy_express.sh

Manta: https://github.com/Illumina/manta.git

manta.sh

Gridss: https://github.com/PapenfussLab/gridss.git

gridss.sh

## 3. Merge the individual vcf per method (SURVIVOR)
 
https://github.com/fritzsedlazeck/SURVIVOR.git

    #the list file should contain vcfs of each individual with path (if it is), one per line. 

    ~/biosoft/SURVIVOR-master/Debug/SURVIVOR merge 70.$method.sample.list 500 1 0 0 0 20 $method.70.vcf
    
    # meaning of number: 
    # Maximum allowed distance
    # Number of caller supporing the result
    # 1: agree on SV type (otherwise: 0)
    # 1: agree on strand (otherwise: 0)
    # Disabled
    # Minimum size of SVs to be taken into account.

## 4. For Each Method: Find High Fixation SV in Each Breed Detected
### 4.1 Find High Fixation SV

*update: the pop_fix_compare.py was modified. the new script output one population at a time and it is easier to change the setting than the previous version. See the script for details. 
pop_fix_compare.py


High and low allele occurrence cutoff: 75-70%, 25-30%


For ref pop such as RJF and WLH: 50%?

	python3 pop_fix_compare.py $method_input.vcf $method_SK_fix.vcf $method_YNLC_fix.vcf
	
	#parallel python3 pop_fix_compare.py {}.60.vcf {}60_sk_fix.vcf {}60_ynlc_fix.vcf ::: manta gridss lumpy
	# The script need to be adjusted with customized breeds and allele frequencies. This should be improved by "argument parser" package in python. 
	#ORDER: input, high_fix_in_first_pop, high_fix_in_sec_pop

### 4.2 Convert VCF to .bedpe
	
	./SURVIVOR vcftobed $high_fix_in_pop.vcf 0 -1 $high_fix_in_pop.bedpe
	
	#parallel ~/biosoft/SURVIVOR-master/Debug/SURVIVOR vcftobed {1}60_{2}_fix.vcf 0 -1 {1}60_{2}_fix.bedpe ::: manta gridss lumpy ::: ynlc sk
	
	# meaning of numbers:
	# minimum size
	# maximum size: -1= no max
		
### 4.3 Get the SV on the same chrm and autosomal
Or any types you want. Sift of interest. 
		
	# For SV on the same chromosome.
	parallel awk \'\$1==\$4{print\$0}\' {1}60_{2}_fix.bedpe \| awk \'\$1\<29{print\$1\"\\t\"\$2\"\\t\"\$3\"\\t\"\$4\"\\t\"\$5\"\\t\"\$6}\' \> {1}60_{2}_intraX_auto.bedped ::: manta lumpy gridss ::: sk ynlc
		
	# For interchromosomal variance
	#parallel awk \'\$1!=\$4{print\$0}\' {1}60_{2}_fix.bedpe \> {1}60_{2}_interX_auto.bedpe ::: manta lumpy gridss ::: sk ynlc


### 4.4 Convert .bedpe to .bed
combine_intervals.py

## I changed this Step.5 to mannual inspection (to prevent emition of small SV due to inclusion of larger SV range)
## 5. Find Overlaps among Different Methods. (Remember to combine after every command)
	/usr/local/bedtools2/bin/bedtools intersect -a lumpy60_sk_intraX_auto.bed -b manta60_sk_intraX_auto.bed -wa -wb -f 0.95 -F 0.95 > lumpy.manta.60_sk_intraX_auto.bed2
	# Repeat for diffferent methods combinations and get a final bed. 
The result will contain SVs only detected by all three methods.

