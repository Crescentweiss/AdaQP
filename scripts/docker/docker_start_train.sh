#!/bin/bash
#SBATCH -J train-adaqp
#SBATCH -p gpu-debug
#SBATCH -A r00114
#SBATCH -o /N/slate/fanjye/repo/GNN_project/AdaQP/scripts/shell_logs/training-yelp-test_%j.txt
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

# variables
NUM_NODES=$SLURM_NNODES
GPUS_PER_NODE=$SLURM_GPUS_PER_NODE
PYTORCH_IMAGE=/N/slate/fanjye/repo/image_sif/adaqp.sif
MASTER_ADDR=$(scontrol show hostnames | head -n 1)


srun --nodes=$NUM_NODES --gres=gpu:$GPUS_PER_NODE apptainer exec \
    --nv \
    --bind /N/slate/fanjye/repo/GNN_project/AdaQP:/N/slate/fanjye/repo/GNN_project/AdaQP \
    --bind /N/slate/fanjye/repo/GNN_project/AdaQP/data:/N/slate/fanjye/repo/GNN_project/AdaQP/data \
    $PYTORCH_IMAGE \
    bash scripts/docker/docker_train.sh $GPUS_PER_NODE $NUM_NODES $MASTER_ADDR

  




