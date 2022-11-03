#!/bin/bash
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --qos normal
#SBATCH -p amd-ep2
#SBATCH -J smp
#SBATCH -o ./report/smcpp.out.%A_%a
#SBATCH -e ./report/smcpp.error.%A_%a
#SBATCH --array=1-28


parentDIR=/storage/zhenyingLab/huangruoshi
CRNTDIR=$parentDIR/108
statDIR=$CRNTDIR/forstats
TXTDIR=/storage/zhenyingLab/huangruoshi/txt_might_be_useful
OUTDIR=$CRNTDIR/SMCPP/

source ~/.bash_profile
module load /soft/modules/modulefiles/bioinfo/smcpp/1.15.2

popfile=$TXTDIR/107.pop_names_cap.DL.txt
pop=`head -n ${SLURM_ARRAY_TASK_ID} $popfile|tail -n1 | awk '{print $1}'`

#########################################################
#______split the population vcf into chromosomes______#
#########################################################


vcftools --gzvcf $CRNTDIR/pop_vcfs/DDDD.input.4_2463neutral_loci.recode.vcf.gz \
  --chr ${SLURM_ARRAY_TASK_ID} \
  --recode --recode-INFO-all \
  --out $CRNTDIR/pop_chrm_vcfs/DDDD_input.4_2463neutral_loci.chr${SLURM_ARRAY_TASK_ID}
  
  
bgzip $CRNTDIR/pop_chrm_vcfs/DDDD_input.4_2463neutral_loci.chr${SLURM_ARRAY_TASK_ID}.recode.vcf
tabix $CRNTDIR/pop_chrm_vcfs/DDDD_input.4_2463neutral_loci.chr${SLURM_ARRAY_TASK_ID}.recode.vcf.gz


#########################################################
#______convert the chromosomal vcf to smcpp input, and also prepare other file needed in teh next step (do check the path and if there's any chromosome/contig is lack of information. If so, remove them mannualy)______#
#########################################################

indvs=`paste -sd ',' $TXTDIR/DDDD.popline.txt`

smc++ vcf2smc pop_chrm_vcfs/DDDD_input.4_chr${SLURM_ARRAY_TASK_ID}.recode.vcf.gz $OUTDIR/DDDD.chr${SLURM_ARRAY_TASK_ID}.smc.gz -m $maskedbed ${SLURM_ARRAY_TASK_ID} DDDD:$indvs

echo /storage/zhenyingLab/huangruoshi/108/SMCPP/DDDD.chr${SLURM_ARRAY_TASK_ID}.smc.gz >> $OUTDIR/DDDD.allchr




