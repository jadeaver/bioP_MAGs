#!/bin/tcsh

#BSUB -n 32
#BSUB -W 2:00
#BSUB -R span[hosts=1]
#BSUB -R select[stc]
#BSUB -J ratatosk
#BSUB -q ccee
#BSUB -o ratatosk_out.%J
#BSUB -e ratatosk_err.%J

# The purpose of this script is to polish filtered long reads with PE short reads from the same sample

conda activate /usr/local/usrapps/n2fix/jdeaver/Ratatosk

set SR_dir = "/share/n2fix/jdeaver/metagenomes/long-read/1.0_short-reads/raw_reads"
set LR_dir = "/share/n2fix/jdeaver/metagenomes/long-read/4.0_filtered-fq"
set output = "/share/n2fix/jdeaver/metagenomes/long-read/8.0_ratatosk"
set software_dir = "/usr/local/usrapps/n2fix/jdeaver/Ratatosk"

foreach file (`ls $LR_dir/*.fq.gz`)
	set base_name = `basename $file .filt.fq.gz`
	set output_file = "${output}/${base_name}_polished"
	set ratatosk = "${software_dir}/bin/Ratatosk"
	set short_read1 = "${SR_dir}/${base_name}_R1.fastq.gz"
	set short_read2 = "${SR_dir}/${base_name}_R2.fastq.gz"
 
	$ratatosk correct -Q 90 -v -G -c 32 -s $short_read1 -s $short_read2 -l $file -o $output_file
end 

conda deactivate

