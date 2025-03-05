#!/bin/tcsh

#BSUB -n 2
#BSUB -W 6:00
#BSUB -R span[hosts=1]
#BSUB -J Fix-Headers
#BSUB -o out.%J
#BSUB -e err.%J

## The purpose of this script is to change the headers in the R2 fastq files so the PE read headers match EXACTLY for ratatosk

set dir = "/share/n2fix/jdeaver/metagenomes/long-read/1.0_short-reads/raw_reads"

foreach file (`ls $dir/*_R2.fastq.gz`)
	set base_name = `basename $file .fastq.gz`
	zcat $file | sed 's/ 2:N:0:/ 1:N:0:/' | gzip > temp_$base_name.fastq.gz && mv temp_$base_name.fastq.gz $file
end
