#!/bin/bash

#BSUB -n 16
#BSUB -W 1:00
#BSUB -J singleM
#BSUB -R "span[hosts=1]"
#BSUB -q ccee
#BSUB -o singlem_out.%J
#BSUB -e singlem_err.%J

# The purpose of this script is to evaluate my MAGs using singleM

source ~/.bashrc

conda activate /usr/local/usrapps/n2fix/jdeaver/singleM

reads="/share/n2fix/jdeaver/metagenomes/long-read/1.0_short-reads/raw_reads"
dir="/share/n2fix/jdeaver/metagenomes/long-read/9.0_MAG-analysis/singlem"
genomes="/share/n2fix/jdeaver/metagenomes/long-read/ANI_95_genomes"

# Profile all samples simultaneously
# Outputs: taxa profile, krona profile, otu table
singlem pipe -1 $reads/*_R1.fastq.gz -2 $reads/*_R2.fastq.gz -p $dir/taxonomy_profile.tsv --taxonomic-profile-krona $dir/krona_profiles.html --otu-table $dir/otu_table.csv --threads 16

# Summarize results as relative abundance at the species level
singlem summarise --input-taxonomic-profile $dir/taxonomy_profile.tsv --output-species-by-site-relative-abundance $dir/relative_abundance-genus.csv --output-species-by-site-level genus

# Summarize results as relative abundance at the genus level
singlem summarise --input-taxonomic-profile $dir/taxonomy_profile.tsv --output-species-by-site-relative-abundance $dir/relative_abundance-species.csv --output-species-by-site-level species

# Estimate the fraction of the metagenomes that is microbial
singlem microbial_fraction -1 $reads/*_R1.fastq.gz -2 $reads/*_R2.fastq.gz -p $dir/taxonomy_profile.tsv > taxonomy_profile.smf.tsv

# Identify which OTU are represented in the MAGs
singlem pipe --genome-fasta-files $genomes/*.fa --otu-table $dir/genomes.otu_table.csv --threads 16

# Exact OTU level
singlem appraise --metagenome-otu-tables $dir/otu_table.csv --genome-otu-tables $dir/genomes.otu_table.csv --plot appraise_plot.svg --output-binned-otu-table $dir/binned_otu.tsv --output-unaccounted-for-otu-table $dir/unbinned_otu.tsv

#Genus level
singlem appraise --metagenome-otu-tables $dir/otu_table.csv --genome-otu-tables $dir/genomes.otu_table.csv --plot $dir/appraise_plot-genus.svg --output-binned-otu-table $dir/binned_otu-genus.tsv --output-unaccounted-for-otu-table $dir/unbinned_otu-genus.tsv --imperfect --sequence-identity 0.89

#Species level
singlem appraise --metagenome-otu-tables $dir/otu_table.csv --genome-otu-tables $dir/genomes.otu_table.csv --plot $dir/appraise_plot-species.svg --output-binned-otu-table $dir/binned_otu-species.tsv --output-unaccounted-for-otu-table $dir/unbinned_otu-species.tsv --imperfect

conda deactivate
