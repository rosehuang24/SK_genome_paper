#!/bin/bash

module load jdk/1.8.0
module load sratoolkit/2.11.2
module load fastqc/0.11.9
module load trimmomatic/0.39
module load bwa/0.7.17
module load gatk/4.0.2.0
module load picard/2.25.1
module load perl/5.34.0
module load samtools/1.13

fastq-dump=/home/zhenyingLab/huangruoshi/biosoft/sratoolkit.3.0.0-centos_linux64/bin/fastq-dump


ref_genome=$REFDIR/Gallus_gallus.GRCg6a.dna.toplevel.fa
ref_bwa=$REFDIR/RefSeq
dbsnp=$REFDIR/newdbSNP.vcf.gz

runfile=$CRNTDIR/run.txt
indvfile=$CRNTDIR/sample.txt #in case I set another name for the SRA run sample

$fastq-dump --split-files $DATADIR/${run}

fastqc -t 4 $DATADIR/${run1}.gz $DATADIR/${run2}.gz

#trim based on the quality check result:

trimmomatic PE -phred33 $DATADIR/${run1}.gz $DATADIR/${run2}.gz \
       $DATADIR/${run1}.${indv}.R1_paired.fq.gz $DATADIR/${run1}.${indv}.R1_unpaired.fq.gz \
       $DATADIR/${run2}.${indv}.R2_paired.fq.gz $DATADIR/${run2}.${indv}.R2_unpaired.fq.gz \
       ILLUMINACLIP:TruSeq3PE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:51

#name consistency
mv $DATADIR/${run1}.${indv}.R1_paired.fq.gz $DATADIR/${indv}.R1_paired.fq.gz
mv $DATADIR/${run2}.${indv}.R2_paired.fq.gz $DATADIR/${indv}.R2_paired.fq.gz

fastqc -t 4 $DATADIR/${indv}.R1_paired.fq.gz $DATADIR/${indv}.R2_paired.fq.gz

#change LB 
bwa mem -t 4 -M -R "@RG\tID:L${run1}_${run2}\tLB:poulation_name\tPL:illumina\tPU:ncbi\tSM:${indv}"  \
        $ref_bwa $DATADIR/${indv}.R1_paired.fq.gz \
        $DATADIR/${indv}.R2_paired.fq.gz > $CRNTDIR/$indv.sam

#check stats
samtools flagstat $CRNTDIR/$indv.sam > $CRNTDIR/samstats.$indv.txt

picard SortSam I=$CRNTDIR/$indv.sam O=$CRNTDIR/${indv}.sorted.bam SO=coordinate

picard MarkDuplicates I=$CRNTDIR/$indv.sorted.bam O=$CRNTDIR/${indv}_dedup.bam M=$CRNTDIR/$indv.metrics REMOVE_DUPLICATES=FALSE

gatk BaseRecalibrator -I $CRNTDIR/${indv}_dedup.bam -R $ref_genome --known-sites $dbsnp -O $CRNTDIR/${indv}_recal.table

gatk ApplyBQSR -R $ref_genome -I $CRNTDIR/${indv}_dedup.bam --bqsr-recal-file $CRNTDIR/${indv}_recal.table -O $CRNTDIR/${indv}_recal.bam


#For haplotypeCaller:
mkdir -p $CRNTDIR/${indv}_raw_chrms_vcfs/
RAWOUTPUTDIR=$CRNTDIR/${indv}_raw_chrms_vcfs

gatk --java-options "-Xmx20G" HaplotypeCaller \
                     -R $ref_genome \
                     -I $CRNTDIR/${indv}_recal.bam \
                     -ERC BP_RESOLUTION \
                     -output-mode EMIT_ALL_SITES \
                     --dbsnp $dbsnp \
                     -O $RAWOUTPUTDIR/${indv}_${SLURM_ARRAY_TASK_ID}.raw.g.vcf.gz



