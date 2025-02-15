#!/bin/bash

export CUDA_DEVICE_MAX_CONNECTIONS=1
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

GPUS_PER_NODE=$1
NUM_NODES=$2
MASTER_ADDR=$3

MASTER_PORT=6000
NODE_RANK=$SLURM_NODEID
WORLD_SIZE=$(($GPUS_PER_NODE*$NUM_NODES))

DISTRIBUTED_ARGS=(
    --nproc_per_node $GPUS_PER_NODE 
    --nnodes $NUM_NODES 
    --node_rank $NODE_RANK 
    --master_addr $MASTER_ADDR 
    --master_port $MASTER_PORT
)

set -x
cd /N/slate/fanjye/repo/GNN_project/AdaQP
torchrun ${DISTRIBUTED_ARGS[@]} main.py \
--dataset yelp \
--num_parts $(($GPUS_PER_NODE*$NUM_NODES)) \
--backend gloo \
--init_method env:// \
--model_name gcn \
--mode AdaQP \
--assign_scheme adaptive \
--logger_level INFO

# # variables
# NUM_SERVERS=1
# WORKERS_PER_SERVER=4
# RANK=0
# # network configurations
# IP=127.0.0.1
# PORT=8888
# # run the script
# torchrun --nproc_per_node=$WORKERS_PER_SERVER --nnodes=$NUM_SERVERS --node_rank=$RANK --master_addr=$IP --master_port=$PORT main.py \
# --dataset yelp \
# --num_parts $(($WORKERS_PER_SERVER*$NUM_SERVERS)) \
# --backend gloo \
# --init_method env:// \
# --model_name gcn \
# --mode Vanilla \
# --logger_level INFO

# # variables
# NUM_SERVERS=1
# WORKERS_PER_SERVER=4
# RANK=0
# # network configurations
# IP=127.0.0.1
# PORT=8888
# # run the script
# torchrun --nproc_per_node=$WORKERS_PER_SERVER --nnodes=$NUM_SERVERS --node_rank=$RANK --master_addr=$IP --master_port=$PORT main.py \
# --dataset yelp \
# --num_parts $(($WORKERS_PER_SERVER*$NUM_SERVERS)) \
# --backend gloo \
# --init_method env:// \
# --model_name gcn \
# --mode AdaQP \
# --assign_scheme adaptive \
# --logger_level INFO

