#!/bin/bash
#SBATCH -J pull-image
#SBATCH -p debug
#SBATCH -A r00114
#SBATCH -o /N/slate/fanjye/repo/GNN_project/AdaQP/scripts/shell_logs/pull-image_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=240g
#SBATCH --time=01:00:00
#SBATCH --mail-type=ALL

# module load cudatoolkit/12.2
# module load apptainer/1.1.8

IMAGE_NAME=adaqp.sif

cd /N/slate/fanjye/repo/image_sif

apptainer pull $IMAGE_NAME docker://raydarkwan/adaqp

# Test python version
# apptainer exec /N/slate/jindjia/sif_image/$IMAGE_NAME python --version