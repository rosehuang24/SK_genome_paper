#!/bin/bash
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --qos normal
#SBATCH -p amd-ep2
#SBATCH -J smp
#SBATCH -o ./report/smcpp.out.%A_%a
#SBATCH -e ./report/smcpp.error.%A_%a
#SBATCH --array=1-10
#SBATCH --mem=8G
source ~/.bash_profile

module load /soft/modules/modulefiles/bioinfo/smcpp/1.15.2

parentDIR=/storage/zhenyingLab/huangruoshi
CRNTDIR=$parentDIR/108
TXTDIR=/storage/zhenyingLab/huangruoshi/txt_might_be_useful
OUTDIR=$CRNTDIR/SMCPP/
maskedbed=/storage/zhenyingLab/huangruoshi/chicken_ref/masked.input4.bed.gz

popfile=$TXTDIR/107.pop_names_cap.DL.txt
pop=`head -n ${SLURM_ARRAY_TASK_ID} $popfile|tail -n1 | awk '{print $1}'`

lines=`paste -sd ' ' $OUTDIR/${pop}.allchr`

smc++ estimate --spline cubic -o $OUTDIR/${pop}.estimate 1.8e-9 $lines

smc++ plot -c $OUTDIR/${pop}.png $OUTDIR/${pop}.estimate/model.final.json -g 1

