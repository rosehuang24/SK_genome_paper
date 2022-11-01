#!/bin/bash

source ~/.bash_profile
ml load plink/2

admixutre=/home/zhenyingLab/huangruoshi/biosoft/admixture_linux-1.3.0/admixture

plink2 --vcf <SNPVCF> -chr-set 28 no-x no-y no-xy --set-all-var-ids @:#\$r_\$a --make-bed --out input.4.for_admix
plink2 --bfile input.4.for_admix  -chr-set 28 no-x no-y no-xy --indep-pairwise 50 10 0.2
plink2 --bfile input.4.for_admix  -chr-set 28 no-x no-y no-xy --extract plink2.prune.in --make-bed --out input.4.for_admix.pruned


##below is a different section for script with paralell slurm job submission

/home/zhenyingLab/huangruoshi/biosoft/admixture_linux-1.3.0/admixture \
          --cv=${SLURM_ARRAY_TASK_ID} input.4.for_admix.pruned.bed \
          -j40 ${SLURM_ARRAY_TASK_ID} | tee input.4.for_admix.pruned.${SLURM_ARRAY_TASK_ID}.log
