#!/bin/tcsh

#BSUB -n 32
#BSUB -W 3:00
#BSUB -R span[hosts=1]
#BSUB -R select[stc]
#BSUB -J metaflye
#BSUB -o out.%J
#BSUB -e err.%J

# The purpose of this script is to create individual sample assemblies from polished long reads

conda activate /usr/local/usrapps/n2fix/jdeaver/flye-2.9.4

set in_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.1_polished/long_reads"
set out_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.1_polished/ratatosk"

foreach file (`ls $in_dir`)
	set base_name = `basename $file _polished.fastq.gz`
	set in = "${in_dir}/$file"
	set out = "${out_dir}/${base_name}" 

	flye --nano-hq $in --out-dir $out --meta --threads 32
end

conda deactivate
