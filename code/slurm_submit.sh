#!/usr/bin/bash

#SBATCH --time 35:00:00
#SBATCH --mem 16GB
#SBATCH --partition exacloud
#SBATCH --error stderr/gbca_baml2.err.%j
#SBATCH --output stdout/gbca_baml2.out.%j
#id=
K=20
RREST=10
/usr/bin/Rscript --vanilla code/lm_baml2.R lm gbca m_e__auc ${K} ${RREST} /home/users/nikolova/projects/gbca/results/baml/ TRUE ${SLURM_JOB_ID}
