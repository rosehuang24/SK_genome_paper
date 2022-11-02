#!/bin/bash



source ~/.bash_profile
beagle=/home/zhenyingLab/huangruoshi/biosoft/beagle.25Nov19.28d.jar
module load selscan/1.3.0 


#selscan requires phased input
java -jar $beagle gt=$OUTDIR/IDG.input.vcf out=$OUTDIR/IDG_phased.vcf
java -jar $beagle gt=$OUTDIR/SK.input.vcf out=$OUTDIR/SK_phased.vcf

#mapfile can be pbtain from plink
plink --vcf input.vcf.gz --chr-set 28 no-x no-y no-xy --recode --out input

#this will create a map file with prefix of "input"
mapfile=input.map

#xp-ehh 
#it is the best to split chromosome/contig

selscan --xpehh --vcf $OUTDIR/IDG_phased.vcf \
                --vcf-ref $OUTDIR/IDG_phased.vcf \
                --map $mapfile \
                --out $OUTDIR/SK_IDG_input.4.chr${SLURM_ARRAY_TASK_ID}
                
###Calculate the average per window using command line.
                
                
