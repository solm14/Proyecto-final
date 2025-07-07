#!/bin/bash
#$ -l h_rt=01:00:00,h_data=2G
#$ -pe shared 1
#$ -N GENES
#$ -cwd
#$ -o /u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/SolCz/IDEA-DE-PROYECTO/logs/descarga.out
#$ -e /u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/SolCz/IDEA-DE-PROYECTO/logs/descarga.err
#$ -M dechavezv

# Ir al directorio del proyecto
cd /u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/SolCz/IDEA-DE-PROYECTO

# Crear carpeta de destino si no existe
mkdir -p SECUENCIA

# Descargar gen ortólogoND1
./datasets download gene symbol ND1 --ortholog Spheniscidae --filename ND1_Spheniscidae.zip

# Descomprimir archivo
unzip -o ND1_Spheniscidae.zip

# Mover y renombrar el archivo .fna a la carpeta SECUENCIA
cp ncbi_dataset/data/rna.fna SECUENCIA/ND1.fa

# Limpiar archivos temporales
rm -rf ncbi_dataset ND1_Spheniscidae.zip

# Descargar gen ortólgo TMEM38A
./datasets download gene symbol TMEM38A --ortholog Spheniscidae --filename TMEM38A_Spheniscidae.zip
unzip -o TMEM38A_Spheniscidae.zip
cp ncbi_dataset/data/rna.fna SECUENCIA/TMEM38A.fa
rm -rf ncbi_dataset TMEM38A_Spheniscidae.zip
