#!/bin/bash
#SBATCH -n 4                # Request one core...
#SBATCH -N 1                # on one node. This parameter matters if you specify -n >1. 
#SBATCH -t 0-2:00           # Runtime, specified in D-H:MM. 
                            # Each task in the job array will be killed if it takes more than 10 minutes.
#SBATCH -p short            # Partition to submit job to.
#SBATCH --mem 8G           # Memory request of 500MB. 1GB is allocated by default, but that is more than needed for this job.
#SBATCH -o hisat2_%A_%a.out # Send output for each job to file named with "fastqc",
                            # and the overall job ID (%A) and the task (%a) in the array. 

# Load module
module load hisat2/2.0.5

# This command assumes you have files named consecutively, like sample_1_R1.fastq, sample_2_R1.fastq, etc.
# Job arrays are technically one job, but with multiple "tasks". When we submit the job like:
# $ sbatch --array=1-4 fastqc_job_array.sh
# There will be 4 tasks to run, one fastqc run for each of the fastq files. 
# In the command below, "${SLURM_ARRAY_TASK_ID}" will be replaced with the task id. 
# For the first task, the full command would be:
# fastqc sample_1_R1.fastq

FASTQ_DIR="/n/scratch2/dp235/Moss55/Moss55_Control_merged" # needs to be the fastq director
HISAT2_INDEXS_FOLDER="/n/scratch2/dp235/Flam_lab_RNAseq/genomes/Gamb"
INDEX_PREFIX='A.gambiae.pestP4'

declare -x array=$(( ${SLURM_ARRAY_TASK_ID} -1))
declare -a sample=( 
MOS55_without_DNV_1
MOS55_without_DNV_2
MOS55_without_DNV_3
MOS55_without_DNV_4
)

# indices folder
HISAT2_INDEXES=${HISAT2_INDEXS_FOLDER}
export HISAT2_INDEXES

hisat2 -q -x ${INDEX_PREFIX} -1 ${FASTQ_DIR}/${sample[$array]}.1.merge.fastq -2 ${FASTQ_DIR}/${sample[$array]}.2.merge.fastq --threads 4 -S ${FASTQ_DIR}_HISAT2/${sample[$array]}.sam
