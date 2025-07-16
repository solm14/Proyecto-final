#!/bin/bash

#Ir al directorio que tiene las secuencias
cd /u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/SolCz/IDEA-DE-PROYECTO2

# Crear carpeta de salida
mkdir -p Secuencia..

# Entrar a la carpeta de salida
cd Secuencia..

# ND1 de Spheniscidae
esearch -db nuccore -query "ND1 [GENE] AND Spheniscidae[ORGN]" | efetch -format fasta > ND1.pingui.fasta

#Para extraer la carperta
grep ">" ND1.pingui.fasta

#Rescribir nombres con Atom
perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' ND1.pingui.fasta > ND1atom.pingui.fasta 

# CYTB de Spheniscidae
esearch -db nuccore -query "CYTB [GENE] AND Spheniscidae[ORGN]" | efetch -format fasta > CYTB.pingui.fasta

#Para extraer la carperta
grep ">" CYTB.pingui.fasta

#Rescribir nombres con Atom
perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' CYTB.pingui.fasta > CYTBatom.pingui.fasta

#Limpiar archivos temporales
rm -r ND1.pingui.fasta CYTB.pingui.fasta

#Como es una gran cantidad de secuencias, se escojen 50 de cada gen

awk '/^>/{n++} n<=30' ND1atom.pingui.fasta > ND1.pingui.fasta
awk '/^>/{n++} n<=30' CYTBatom.pingui.fasta > CYTB.pingui.fasta
rm -r ND1atom.pingui.fasta CYTBatom.pingui.fasta

##Hacer con la familia Alcidae

# ND1 de Alcidae
esearch -db nuccore -query "ND1 [GENE] AND Alcidae[ORGN]" | efetch -format fasta > ND1.fraile.fasta

#Para extraer la carperta
grep ">" ND1.fraile.fasta

#Rescribir nombres con Atom
perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' ND1.fraile.fasta > ND1atom.fraile.fasta

# CYTB de Alcidae
esearch -db nuccore -query "CYTB [GENE] AND Alcidae[ORGN]" | efetch -format fasta > CYTB.fraile.fasta

#Para extraer la carperta
grep ">" CYTB.fraile.fasta

#Rescribir nombres con Atom
perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' CYTB.fraile.fasta > CYTBatom.fraile.fasta

#Limpiar archivos temporales
rm -r ND1.fraile.fasta CYTB.fraile.fasta

#Escojer una sola secuencia de las fastas del individuio externo (Alcidae)

awk '/^>/{n++} n<=1' ND1atom.fraile.fasta > ND1.fraile.fasta
awk '/^>/{n++} n<=1' CYTBatom.fraile.fasta > CYTB.fraile.fasta
rm -r ND1atom.fraile.fasta CYTBatom.fraile.fasta

#Unir las fastas del la familia principal (Spheniscidae) y del grupo externo (Alcidae) en una sola, para cada gen

cat ND1.pingui.fasta ND1.fraile.fasta > ND1.completo.fasta
cat CYTB.pingui.fasta CYTB.fraile.fasta > CYTB.completo.fasta
rm -r ND1.pingui.fasta CYTB.pingui.fasta *fraile.fasta

#Habilitar modules
source /etc/profile.d/modules.sh

#Copiar MUSCLE
cp ../../muscle3.8.31_i86linux64 ./

#Alinear con MUSCLE los archivos .fasta
for filename in *completo.fasta; do
    ./muscle3.8.31_i86linux64 -in $filename -out muscle_$filename -maxiters 1 -diags
done

#Cargar IQ-TREE
. /u/local/Modules/default/init/modules.sh
module load iqtree/2.2.2.6

#Ejecutar IQ-TREE para cada MUSCLE
for aln in muscle_*.fasta; do
    iqtree2 -s ${aln}
done

#Unir todos los archivos .treefile
cat *.treefile > Alltrees.tree

#Mover Alltrees.tree al directorio IDEA-DE-PROYECTO2
mv Alltrees.tree ../
