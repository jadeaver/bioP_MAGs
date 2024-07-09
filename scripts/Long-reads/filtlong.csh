#!/bin/tcsh

#BSUB -n 4
#BSUB -W 4:00
#BSUB -R span[hosts=1]
#BSUB -J filtlong
#BSUB -o out.%J
#BSUB -e err.%J


set input_folder = /share/n2fix/jdeaver/metagenomes/long-read/3.1_barcoded-fq
set output_folder = /share/n2fix/jdeaver/metagenomes/long-read/4.0_filtered-fq
set software_dir = /usr/local/usrapps/n2fix/jdeaver/Filtlong

foreach file (`ls $input_folder/*.fq.gz`)
	set base_name = `basename $file .fq.gz`
	set output_file = "${output_folder}/${base_name}.filt.fq.gz"
	set filtlong = "${software_dir}/bin/filtlong"
	
	$filtlong --keep_percent 90 --min_length 1500 --min_mean_q 90 $file | gzip > $output_file

	echo "Processed $base_name"

end
	
