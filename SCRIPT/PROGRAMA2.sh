#!/bin/bash

#$ -l h_rt=01:00:00,h_data=2G    
#$ -pe shared 1                 
#$ -N TREE                       
#$ -cwd                         
#$ -o logs/tree.out              
#$ -e logs/tree.err             
#$ -M dechavezv                  

# Ir al directorio que contiene las secuencias
cd /u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/SolCz/IDEA-DE-PROYECTO/SECUENCIA

# Habilitar entorno de módulos
source /etc/profile.d/modules.sh

# Copiar el ejecutable de MUSCLE si no lo has hecho ya
cp ../../muscle3.8.31_i86linux64 ./

# Alinear con MUSCLE cada archivo .fa
for gene in *.fa; do
    ./muscle3.8.31_i86linux64 -in $gene -out muscle_$gene -maxiters 1 -diags
done

# Cargar el módulo de IQ-TREE
module load iqtree/2.2.2.6

# Ejecutar IQ-TREE para cada alineamiento generado por MUSCLE
for aln in muscle_*.fa; do
    iqtree2 -s ${aln}
done

# Unir todos los archivos .treefile en uno solo
cat *.treefile > Alltrees.tree

# Mover Alltrees.tree al directorio IDEA-DE-PROYECTO
mv Alltrees.tree ../
