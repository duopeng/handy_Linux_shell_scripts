#!/bin/bash
#SBATCH -n 2                # Request one core...
#SBATCH -N 1                # on one node. This parameter matters if you specify -n >1. 
#SBATCH -t 0-12:00           # Runtime, specified in D-H:MM. 
                            # Each task in the job array will be killed if it takes more than 10 minutes.
#SBATCH -p short            # Partition to submit job to.
#SBATCH --mem 16G           # Memory request of 500MB. 1GB is allocated by default, but that is more than needed for this job.
#SBATCH -o GFPRead_%A_%a.out # Send output for each job to file named with "fastqc",
                            # and the overall job ID (%A) and the task (%a) in the array. 

# Load module
module load gcc/6.2.0
module load blast/2.6.0+
module load perl/5.24.0

# This command assumes you have files named consecutively, like sample_1_R1.fastq, sample_2_R1.fastq, etc.
# Job arrays are technically one job, but with multiple "tasks". When we submit the job like:
# $ sbatch --array=1-4 fastqc_job_array.sh
# There will be 4 tasks to run, one fastqc run for each of the fastq files. 
# In the command below, "${SLURM_ARRAY_TASK_ID}" will be replaced with the task id. 
# For the first task, the full command would be:
# fastqc sample_1_R1.fastq


declare -x array=$(( ${SLURM_ARRAY_TASK_ID} -1))
declare -a sample=( 
141870-7.merge.GFP11reads.fasta
141870-11.merge.GFP11reads.fasta
141870-19.merge.GFP11reads.fasta
141870-21.merge.GFP11reads.fasta
)

cd /n/scratch2/dp235/illumina_2017_11_TcTSKO_201905analysis

perl /n/scratch2/dp235/illumina_2017_11_TcTSKO_201905analysis/scripts/blast_reads_and_parseResult.v1.0-O2.pl -q /n/scratch2/dp235/illumina_2017_11_TcTSKO_201905analysis/20171114run_GFP11reads/${sample[$array]} -d /n/scratch2/dp235/illumina_2017_11_TcTSKO_201905analysis/identify_all_TcTS_in_Brazil_Pacbio/90perc_100minlen_500maxgap.blast2transcripts.blastoutxml.parsedNfiltered.aln1 -m 96 -t 2 -minmatchlen 20

