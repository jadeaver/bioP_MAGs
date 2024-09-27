#!/bin/tcsh

#BSUB -n 16
#BSUB -W 15:00
#BSUB -J minimap2
#BSUB -R "span[hosts=1]"
#BSUB -o minimap2_out.%J
#BSUB -e minimap2_err.%J

# The purpose of this script is to map each short read set against each assembly using minimap2. Then each sam file needs to be converted to a sorted bam file and indexed.
# Assemblies were single and co-assebled from ratatosk polished long reads

conda activate /usr/local/usrapps/n2fix/hwchu/minimap2_2.28

set short_reads = "/share/n2fix/jdeaver/metagenomes/long-read/1.0_short-reads/raw_reads"
set asmbl_parent_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.1_polished/ratatosk"
set map_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.0_mapping/on_polished/ratatosk/SR"

set reads = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3)
set asmbl_dirs = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3 co-assembly D1 D2 D3 D4)
set asmbl_name = "assembly.fasta"

foreach read ($reads)
	foreach asmbl_dir ($asmbl_dirs)
		set read1_file = "${short_reads}/${read}_R1.fastq.gz"
		set read2_file = "${short_reads}/${read}_R2.fastq.gz"
		set asmbl_file = "${asmbl_parent_dir}/${asmbl_dir}/${asmbl_name}"
		set output_dir = "${map_dir}/${read}_${asmbl_dir}"

		if (! -d $output_dir) then
			mkdir -p $output_dir
		endif

		set output = "${output_dir}/${read}.sam"

		minimap2 -t 16 -ax sr $asmbl_file $read1_file $read2_file > $output

		set bam_file = "${output_dir}/${read}.bam"

		samtools sort $output -@ 14 -o $bam_file
		samtools index $bam_file -@ 14
	end
end

conda deactivate
