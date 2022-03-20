#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=relernn
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --partition matador
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=9G
#SBATCH --gpus-per-node=2

source activate recomb

# used the Dryobates pubescens mutation rate

SEED="42"
MU="2.42e-9"
DIR="./nuttallii_relernn/"
VCF="./nuttallii_relernn.vcf"
GENOME="./dryobates.genome.bed"
GENTIME="1"

# Simulate data
ReLERNN_SIMULATE \
    --vcf ${VCF} \
    --genome ${GENOME} \
    --projectDir ${DIR} \
    --assumedMu ${MU} \
    --seed ${SEED} \
    --assumedGenTime ${GENTIME} \
    --unphased

# Training
ReLERNN_TRAIN \
    --projectDir ${DIR} \
    --seed ${SEED} \
    --nCPU 40

# Predict recombination rates
ReLERNN_PREDICT \
    --vcf ${VCF} \
    --projectDir ${DIR} \
    --seed ${SEED} \
    --unphased
    
# bootstrap and correct
ReLERNN_BSCORRECT \
    --projectDir ${DIR} \
    --seed ${SEED} \
    --nCPU 40 \
    --nSlice 100 \
    --nReps 100
    
