#!/bin/tcsh

#BSUB -n 1
#BSUB -W 30
#BSUB -R span[hosts=1]
#BSUB -J samtools
#BSUB -o out.%J
#BSUB -e err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/samtools-1.2

set input_folder = /share/n2fix/jdeaver/metagenomes/long-read/3.0_barcoded-bam
set output_folder = /share/n2fix/jdeaver/metagenomes/long-read/3.1_barcoded-fq

foreach file (`ls $input_folder/*.bam`)
	set base_name = `basename $file .bam`
	set output = "${output_folder}/${base_name}.fq.gz"

	samtools fastq $file > $output
	
	echo "Processed $base_name"

end

conda deactivate
