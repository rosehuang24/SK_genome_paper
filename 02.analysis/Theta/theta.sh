#!/bin/bash
#SBATCH --array=1-10

source ~/.bash_profile


module load vcftools/0.1.16
module load htslib/1.12


file=107.pop_names_cap.DL.txt
pop=`head -n ${SLURM_ARRAY_TASK_ID} $file|tail -n1 | awk '{print $1}'`
popvcf=$pop.input.4.vcf.gz #(repetitve removed)

python3 $scriptDIR/segregating_sites.py -I $popvcf -O $pop.input4.segsite.vcf

grep -v "#" $pop.input4.segsite.vcf | wc -l > $pop.input4.segsite.count

#total automosomal length is 960,796,756. Repetitive region total length for autosomes is 190,557,588. The remaining region length is 770,239,168
