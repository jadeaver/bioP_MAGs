#!/bin/tcsh

#BSUB -n 16
#BSUB -W 20:00
#BSUB -R span[hosts=1]
#BSUB -J sortmerna
#BSUB -o out.%J
#BSUB -e err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/sortmerna-4.3.7

set input_folder = /share/n2fix/jdeaver/metatranscriptomes/3.0_fastp
set output_folder = /share/n2fix/jdeaver/metatranscriptomes/4.0_sortmerna
set reference_folder = /share/n2fix/jdeaver/metatranscriptomes/4.0_sortmerna/rRNA_databases_v4

foreach file (`ls $input_folder/*_R1.trimmed.fastq.gz`)
	set base_name = `basename $file _R1.trimmed.fastq.gz`
	set r2_file = "${input_folder}/${base_name}_R2.trimmed.fastq.gz"
	
	set ref = "${reference_folder}/smr_v4.3_fast_db.fasta"
	set idx = "${output_folder}/idx"
	set work_dir = "${output_folder}/${base_name}_run"
	
	set sorted_rRNA_prefix = "${output_folder}/${base_name}_rRNA-reads"
	set sorted_non_prefix = "${output_folder}/${base_name}_non-rRNA-reads"

	sortmerna --ref $ref --reads $file --reads $r2_file --workdir $work_dir --idx-dir $idx --index 0 --threads 16 --num_alignments 1 --no-best --fastx --paired_out --out2 --aligned $sorted_rRNA_prefix --other $sorted_non_prefix

  echo "Processed $base_name"

end

conda deactivate
