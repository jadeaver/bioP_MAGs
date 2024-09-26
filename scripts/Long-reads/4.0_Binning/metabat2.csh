#!/bin/tcsh

#BSUB -n 16
#BSUB -W 12:00
#BSUB -J metabat2
#BSUB -R "span[hosts=1]"
#BSUB -o mb2_out.%J
#BSUB -e mb2_err.%J

# The purpose of this script is to bin reads mapped to each of the 9 assemblies accounting for differential coverage of all 8 samples to each assembly (i.e. all samples are mapped to each assembly and binned together for that assembly).

conda activate /usr/local/usrapps/n2fix/hwchu/metabat2_2.15-2

set merged_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.0_mapping/on_polished/ratatosk/merged"
set asmbl_parent_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.1_polished/ratatosk"

set asmbl_dirs = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3 co-assembly)
set asmbl_name = "assembly.fasta"

foreach asmbl_dir ($asmbl_dirs)
	set merged = "${merged_dir}"
	set dir = "${merged}/${asmbl_dir}"

	if (! -d $dir) then
		mkdir -p $dir
	endif

	cp ${merged}/*_${asmbl_dir}/* $dir/

	set asmbl_file = "${asmbl_parent_dir}/${asmbl_dir}/${asmbl_name}"

	jgi_summarize_bam_contig_depths --outputDepth $dir/depth.txt $dir/*.bam

	metabat2 -t 16 -i $asmbl_file -a $dir/depth.txt -o $dir/bins

end

conda deactivate
