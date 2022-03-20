#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=filter1
#SBATCH --nodes=1 --ntasks=1
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-44

# define input files from vcf list
vcf_list=$( head -n${SLURM_ARRAY_TASK_ID} vcf_list.txt | tail -n1 )
input_array=${vcf_list%.g.vcf}

# define main working directory
workdir=/lustre/scratch/jmanthey/06_dryobates

# pull out header and add to filtered vcf file
grep "#" ${workdir}/03_vcf/${input_array}.g.vcf > ${workdir}/03_vcf/${input_array}.filtered.vcf

# filter our rows that have low quality filters, genotyped sites with quality less than 20, and null alleles (* in col 4)
grep -v "#" ${workdir}/03_vcf/${input_array}.g.vcf | grep -v "LowQual" | awk '$6 >= 20 || $6 ~ /^\./' | awk '$5 !~ /*/' >> ${workdir}/03_vcf/${input_array}.filtered.vcf

# run vcftools with SNP output spaced 100kbp, only biallelic SNPs with no missing data and no outgroup 
vcftools --vcf ${workdir}/03_vcf/${input_array}.filtered.vcf --remove-indv Dendropicos_abyssinicus_EB034 --max-missing 1.0 --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 1 --thin 100000 --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/06_admixture/${input_array}

# run vcftools with SNP output, only biallelic SNPs with max missing = 2 individuals and no outgroup 
vcftools --vcf ${workdir}/03_vcf/${input_array}.filtered.vcf --remove-indv Dendropicos_abyssinicus_EB034 --max-missing 0.85 --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 1 --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/07_admixture_windows/${input_array}

# bgzip and tabix index files that will be subdivided into windows for ADMIXTURE
# bgzip
bgzip ${workdir}/07_admixture_windows/${input_array}.recode.vcf
#tabix
tabix -p vcf ${workdir}/07_admixture_windows/${input_array}.recode.vcf.gz

# run vcftools with SNP output for ReLERNN for D. pubescens, only biallelic SNPs with max missing = 1 individual
vcftools --vcf ${workdir}/03_vcf/${input_array}.filtered.vcf --keep pubescens.txt --max-missing 0.8 --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 1 --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/04_relernn/${input_array}_pubescens

# run vcftools with SNP output for ReLERNN for D. nuttallii, only biallelic SNPs with max missing = 1 individual
vcftools --vcf ${workdir}/03_vcf/${input_array}.filtered.vcf --keep nuttallii.txt --max-missing 0.8 --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 1 --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/04_relernn/${input_array}_nuttallii

# run vcftools with SNP output for ReLERNN for D. scalaris, only biallelic SNPs with max missing = 1 individual
vcftools --vcf ${workdir}/03_vcf/${input_array}.filtered.vcf --keep scalaris.txt --max-missing 0.8 --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 1 --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/04_relernn/${input_array}_scalaris

# run vcftools with SNP and invariant site output for phylogenetics and stats, 20% max missing data, no indels
vcftools --vcf ${workdir}/03_vcf/${input_array}.filtered.vcf --max-missing 0.8 --minDP 6 --max-meanDP 50 --max-alleles 2 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_trees100kbp/${input_array}

# bgzip and tabix index files that will be subdivided into windows for phylogenetics and stats
# bgzip
bgzip ${workdir}/05_trees100kbp/${input_array}.recode.vcf
#tabix
tabix -p vcf ${workdir}/05_trees100kbp/${input_array}.recode.vcf.gz

