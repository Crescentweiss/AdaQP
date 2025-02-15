#!/bin/bash
#SBATCH -J preprocess-data
#SBATCH -p gpu-debug
#SBATCH -A r00114
#SBATCH -o /N/slate/fanjye/repo/GNN_project/AdaQP/scripts/shell_logs/preprocess-data_%j.txt
#SBATCH --nodes=1
#SBATCH --gpus-per-node=4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=120g
#SBATCH --time=01:00:00
#SBATCH --mail-type=ALL

# module load conda
# conda activate /N/slate/fanjye/openclip
module load cudatoolkit
cd /N/slate/fanjye/repo/GNN_project/AdaQP

apptainer exec \
  --nv \
  --bind /N/slate/fanjye/repo/GNN_project/AdaQP:/N/slate/fanjye/repo/GNN_project/AdaQP \
  --bind /N/slate/fanjye/repo/GNN_project/AdaQP/data:/N/slate/fanjye/repo/GNN_project/AdaQP/data \
  /N/slate/fanjye/repo/image_sif/adaqp.sif \
  python /N/slate/fanjye/repo/GNN_project/AdaQP/graph_partition.py \
    --dataset yelp \
    --partition_size 4 \
    --raw_dir data/dataset \
    --partition_dir data/part_data




