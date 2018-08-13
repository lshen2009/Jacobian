#!/bin/bash

#SBATCH -n 12
#SBATCH -N 1
#SBATCH -t 0-00:01
#SBATCH -p huce_intel
#SBATCH --mem=2000
#SBATCH --mail-type=END

#export OMP_NUM_THREADS=$SLURM_NTASKS
export OMP_NUM_THREADS=12
./main > log
