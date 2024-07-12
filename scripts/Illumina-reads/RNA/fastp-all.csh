#!/bin/tcsh

#BSUB -n 8
#BSUB -W 08:00
#BSUB -R span[hosts=1]
#BSUB -J fastp
#BSUB -o out.%J
#BSUB -e err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/fastp

set input_folder = /share/n2fix/jdeaver/metatranscriptomes/1.0_raw-data
set output_folder = /share/n2fix/jdeaver/metatranscriptomes/3.0_fastp

foreach file (`ls $input_folder/*_R1.fastq.gz`)
    set base_name = `basename $file _R1.fastq.gz`
	
    set r2_file = "${input_folder}/${base_name}_R2.fastq.gz"

    set trimmed_r1_file = "${output_folder}/${base_name}_R1.trimmed.fastq.gz"
    set trimmed_r2_file = "${output_folder}/${base_name}_R2.trimmed.fastq.gz"
    
    set report_file = "${output_folder}/${base_name}.html"
    set report_file2 = "${output_folder}/${base_name}.json"

    fastp --in1 $file --out1 $trimmed_r1_file --in2 $r2_file --out2 $trimmed_r2_file --adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --adapter_sequence_r2=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --thread=8 --html=$report_file --json=$report_file2 -g

    echo "Processed $base_name"

end

conda deactivate

