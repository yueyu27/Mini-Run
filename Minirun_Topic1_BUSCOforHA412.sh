
#===========================================================
#
# Mini Run - Topic 1
#
# Goal: Run BUSCO for HA412 annotation
#
# 2025 March 17th
#
#===========================================================

# -- Server: Narval
# -- Software used: 
#					- BUSCO 5.5.0
#					-


# -- Load HA412 - FASTA/ GFF3/ PEP file
cd /home/yueyu/scratch/HA412

ls -thor
-rw-r-----. 1 yueyu 986K Dec 10 21:33 Ha412HOv2.0-20181130.fasta.fai
-rw-r-----. 1 yueyu 3.1G Dec 10 21:33 Ha412HOv2.0-20181130.fasta
-rw-r-----. 1 yueyu  17M Mar 17 16:13 HAN412_Final.sorted.pep
-rwxr-x---. 1 yueyu 109M Mar 17 16:13 HAN412_Final.sorted.gff3


awk '$3 == "gene" {count++} END {print count}' HAN412_Final.sorted.gff3
# Annotation of 46,768 genes (from 3rd column)

grep ">" HAN412_Final.sorted.pep | wc -l
# Annotation of 45,008 proteins





# -- Run: BUSCO

nano run_busco_HA412.sh
#----------------- run_busco_HA412.sh --------------
#!/bin/bash
#SBATCH --account=def-rieseber
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=20
#SBATCH --mem=50G

module load StdEnv/2020 gcc/9.3.0 python/3.10 augustus/3.5.0 hmmer/3.3.2 blast+/2.13.0 metaeuk/6 prodigal/2.6.3 r/4.3.1 bbmap/38.86
source ~/busco_env/bin/activate

cd /home/yueyu/scratch/HA412

PEP="HAN412_Final.sorted.pep"
OUTPUT="HA412_BUSCO_2025Mar17"

busco --offline -m protein -c 20 -i $PEP -o $OUTPUT -l /home/yueyu/scratch/GA/Hdeb2414_merged_Hap1_andHap2/reviewed_assembly/busco_downloads/lineages/eudicots_odb10 

#----------------- run_busco_HA412.sh (END) --------------

#Submitted batch job 41402569 - DONE 17 Mar 2025 

seff 41402569

Job ID: 41402569
Cluster: narval
User/Group: yueyu/yueyu
State: COMPLETED (exit code 0)
Nodes: 1
Cores per node: 20
CPU Utilized: 00:51:45
CPU Efficiency: 6.20% of 13:55:20 core-walltime
Job Wall-clock time: 00:41:46
Memory Utilized: 1.76 GB
Memory Efficiency: 3.52% of 50.00 GB






#  ======== BUSCO result for HA412  ========

cat short_summary.specific.eudicots_odb10.HA412_BUSCO_2025Mar17.txt

# BUSCO version is: 5.5.0
# The lineage dataset is: eudicots_odb10 (Creation date: 2024-01-08, number of genomes: 31, number of BUSCOs: 2326)
# Summarized benchmarking in BUSCO notation for file /lustre07/scratch/yueyu/HA412/HAN412_Final.sorted.pep
# BUSCO was run in mode: proteins

    ***** Results: *****

    C:94.0%[S:81.7%,D:12.3%],F:0.9%,M:5.1%,n:2326
    2185    Complete BUSCOs (C)
    1900    Complete and single-copy BUSCOs (S)
    285 Complete and duplicated BUSCOs (D)
    21  Fragmented BUSCOs (F)
    120 Missing BUSCOs (M)
    2326    Total BUSCO groups searched

    Dependencies and versions:
    hmmsearch: 3.3
    busco: 5.5.0

#  ================================================








# ------------------------------- Optional code: if you only have GFF3+FASTA

# -- Install gffread for protein conversion
# Use https://github.com/gpertea/gffread

cd /home/yueyu/scratch/Annotation
git clone https://github.com/gpertea/gffread
cd gffread
make release

cd /home/celphin/scratch/Annotation/liftoff/output
/home/celphin/scratch/Annotation/gffread/gffread -h


# -- Run: gff3 + FASTA --> protein.fa

/home/celphin/scratch/Annotation/gffread/gffread -g ../data/${SPP_query}.fasta \
 ${SPP_query}_liftoffpolish.gff3 \
 -y ${SPP_query}_proteins.fa

# END