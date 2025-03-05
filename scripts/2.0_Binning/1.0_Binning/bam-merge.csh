#!/bin/tcsh

#BSUB -n 16
#BSUB -W 4:00
#BSUB -J samtools
#BSUB -R "span[hosts=1]"
#BSUB -o samtools-merge_out.%J
#BSUB -e samtools-merge_err.%J

# The purpose of this script is to merge long and short read sorted bam files for each read/assembly combination

conda activate /usr/local/usrapps/n2fix/hwchu/minimap2_2.28

set SR_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.0_mapping/on_polished/ratatosk/SR"
set LR_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.0_mapping/on_polished/ratatosk/LR"
set merged_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.0_mapping/on_polished/ratatosk/merged"

set reads = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3)
set asmbl_dirs = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3 co-assembly D1 D2 D3 D4)

foreach read ($reads)
	foreach asmbl_dir ($asmbl_dirs)
		set input_file1 = "${SR_dir}/${read}_${asmbl_dir}/*.bam"
		set input_file2 = "${LR_dir}/${read}_${asmbl_dir}/*.bam"
		set output_dir = "${merged_dir}/${read}_${asmbl_dir}"

		if (! -d $output_dir) then
			mkdir -p $output_dir
		endif

		set output_file = "${output_dir}/${read}.bam"

		samtools merge -@ 14 -o $output_file $input_file1 $input_file2
		samtools index -@ 14 $output_file
	end
end

conda deactivate
