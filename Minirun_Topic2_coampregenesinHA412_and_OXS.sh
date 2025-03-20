#===========================================================
#
# Mini Run - Topic 2
#
# Goal: Compare genes in HA412 and OXS
#
# 2025 March 18th
#
#===========================================================

# Narval

cd /home/yueyu/scratch/compare_genes

#--- OXS -- 

OXS="/home/yueyu/scratch/Annotation/liftoff/FASTA_OXS/OXS.gtf"

awk '$3 == "gene" {count++} END {print count}' $OXS
# 74,608 genes 

awk '$3 == "gene"' $OXS > OXS_74608_genes.txt



#--- HA412 -- 

HA412="/home/yueyu/scratch/HA412/HAN412_Final.sorted.gff3"

awk '$3 == "gene" {count++} END {print count}' $HA412
# 46,768 genes (from 3rd column)

awk '$3 == "gene"' $HA412 > HA412_46768_qqqgenes.txt



# What to do next??

 # END