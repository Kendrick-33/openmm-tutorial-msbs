#!/bin/bash
#SBATCH --job-name=openmm-vsc-cpu
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=5GB
#SBATCH --time=5:00:00

# Setup our OpenMM environment
module load OpenMM/8.0.0-foss-2022a MDTraj/1.9.7-foss-2022a matplotlib/3.5.2-foss-2022a jax/0.3.25-foss-2022a lxml/4.9.1-GCCcore-11.3.0 PyYAML/6.0-GCCcore-11.3.0
. ${VSC_DATA}/venvs/${VSC_ARCH_LOCAL}/3.9.5-GCCcore-10.3.0/bin/activate

# Set the number of threads.
export OPENMM_CPU_THREADS=${SLURM_CPUS_PER_TASK}
# Go to the directory where sbatch was called
cd ${SLURM_SUBMIT_DIR}

# Run the notebook. (everything on a single line)
time jupyter nbconvert --to notebook --execute --allow-errors --ExecutePreprocessor.timeout=-1 01_noninteractive_notebook_on_hpc.ipynb
