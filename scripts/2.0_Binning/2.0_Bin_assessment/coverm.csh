#!/bin/tcsh

#BSUB -n 16
#BSUB -W 4:00
#BSUB -J coverM
#BSUB -R "span[hosts=1]"
#BSUB -q ccee
#BSUB -o coverM_out.%J
#BSUB -e coverM_err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/coverM-0.7.0

set dir = "/share/n2fix/jdeaver/metagenomes/long-read/1.0_short-reads/raw_reads"
set bam_dir = "/share/n2fix/jdeaver/metagenomes/long-read/9.1_anvio/02_estimate_cov/BAM"
set bin_dir = "/share/n2fix/jdeaver/metagenomes/long-read/9.1_anvio/02_estimate_cov/bins"
set TMPDIR = "/share/n2fix/jdeaver/tmp"

coverm genome --coupled $dir/B2_D1_R1.fastq.gz $dir/B2_D1_R2.fastq.gz $dir/B3_D1_R1.fastq.gz $dir/B3_D1_R2.fastq.gz $dir/B2_D2_R1.fastq.gz $dir/B2_D2_R2.fastq.gz $dir/B3_D2_R1.fastq.gz $dir/B3_D2_R2.fastq.gz $dir/B2_D3_R1.fastq.gz $dir/B2_D3_R2.fastq.gz $dir/B3_D3_R1.fastq.gz $dir/B3_D3_R2.fastq.gz $dir/B1_D4_R1.fastq.gz $dir/B1_D4_R2.fastq.gz $dir/B2_D4_R1.fastq.gz $dir/B2_D4_R2.fastq.gz --genome-fasta-directory $bin_dir -x fa -o stringent_coverm_output.tsv -t 16 --min-read-percent-identity 95 --min-read-aligned-percent 75 --min-covered-fraction 0

coverm genome --coupled $dir/B2_D1_R1.fastq.gz $dir/B2_D1_R2.fastq.gz $dir/B3_D1_R1.fastq.gz $dir/B3_D1_R2.fastq.gz $dir/B2_D2_R1.fastq.gz $dir/B2_D2_R2.fastq.gz $dir/B3_D2_R1.fastq.gz $dir/B3_D2_R2.fastq.gz $dir/B2_D3_R1.fastq.gz $dir/B2_D3_R2.fastq.gz $dir/B3_D3_R1.fastq.gz $dir/B3_D3_R2.fastq.gz $dir/B1_D4_R1.fastq.gz $dir/B1_D4_R2.fastq.gz $dir/B2_D4_R1.fastq.gz $dir/B2_D4_R2.fastq.gz --genome-fasta-directory $bin_dir -x fa -m mean -o mean_coverm_output.tsv -t 16 --min-read-percent-identity 0 --min-read-aligned-percent 0 --min-covered-fraction 0

conda deactivate
