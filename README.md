# Análisis evolutivo filogenéticamente entre genes equivalentes de la familia Spheniscidae

Este proyecto tiene como objetivo reconstruir la historia evolutiva de pingüinos de la familia Spheniscidae mediante el análisis de tres genes ortólogos mitocondriales (BRCA1, CYTB y ATP8), las cuales, se obtuvieron de la base de datos NCBI.

---

## En primera instancia

Este documento proporciona los pasos necesarios para ejecutar el análisis filogenético en una supercomputadora, comenzando con la descarga de secuencias y finalizando con la visualización de los árboles, para luego comenzar con el análisis evolutivo. 
---

## Prerrequisitos

* Contar con acceso a una supercomputadora.
* Tener disponible una terminal o Git Bash.
* Disponer de los siguientes programas instalados en el ordenador y en una carpeta propia de la supercomputadora:
  * `datasets` de NCBI para la descarga de secuencias.
  * `MUSCLE` para realizar alineamientos múltiples.
  * `IQ-TREE` 2 para llevar a cabo la inferencia filogenética.
  * `FigTree` para la visualización de árboles evolutivos.
  * `Atom` como editor de archivos en formato FASTA.

---

## Instalación

```bash
# 1. Conexión a la supercomputadora (Hofmann)
Primero, se accede al sistema remoto utilizando el siguiente comando:

ssh dechavez@hoffman2.idre.ucla.edu

# 2. Solicitud de un nodo de cómputo
Una vez dentro, se solicita un nodo de trabajo con:

qrsh

# 3. Navegar al directorio de trabajo
Se dirige al directorio donde se desarrollará el proyecto:

cd $SCRATCH/Bioinformatica-PUCE/RepotenBio/SolCz

# 4. Crear el entorno de trabajo
Se genera un nuevo directorio para el proyecto, copia el ejecutable de ''datasets'', y se accede a la nueva carpeta:

mkdir Proyecto final
cp datasets Proyecto final/
cd Proyecto final/
```

### Descarga de genes ortólogos y Procesamiento de cada archivo ZIP
```bash
# Descarga de genes ortólogos
Se utiliza el comando ''datasets'' para descargar los genes mitocondriales BRCA1, CYTB y ATP8 correspondientes a especies de la familia Spheniscidae:

./datasets download gene symbol BRCA1 --ortholog Spheniscidae --filename BRCA1_Spheniscidae.zip
./datasets download gene symbol CYTB --ortholog Spheniscidae --filename CYTB_Spheniscidae.zip
./datasets download gene symbol ATP8 --ortholog Spheniscidae --filename ATP8_Spheniscidae.zip

# Procesamiento de cada archivo ZIP
Se descomprime los archivos descargados, renombra las secuencias, y organiza los archivos FASTA:

* BRCA1
unzip BRCA1_Spheniscidae.zip
cd ncbi_dataset/data
mv rna.fna BRCA1.fa
cp BRCA1.fa ../../../
cd ../../../
rm -r ncbi_dataset

* (Se repite con CYTB y ATP8)

# Organizar secuencias
Una vez renombradas, junta todas las secuencias en una carpeta:

cat *.fa > Secuencias/
```

### Transferencia y edición local
```bash
Se copia la carpeta de secuencias a la computadora local para su edición por medio de Atom, y luego vuelve a transferir al entorno de la supercomputadora:

# Transferencia desde la supercomputadora a la máquina local
scp -r dechavez@hoffman2.idre.ucla.edu:/u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/SolCz/Proyecto final/Secuencias ./

# editar con Atom

# Envío de vuelta a la supercomputadora
scp -r ./Secuencias dechavez@hoffman2.idre.ucla.edu:/u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/SolCz/Proyecto final/
```

### Alineamiento de secuencias y análisis filogenético
```bash
Se ejecuta los alineamientos múltiples con muscle e infiere los árboles filogenéticos con iq-tree:

cd SECUENCIAS
cp ../../muscle3.8.31_i86linux64 ./

# Alinear con muscle cada gen 
for gene in *.fa ; do
> ./muscle3.8.31_i86linux64 -in $gene -out muscle_$gene -maxiters 1 -diags
>done

# Cargar el módulo iq-tree y realizar análisis
module load iqtree/2.2.2.6
for muscle in muscle_* ; do
> iqtree2 -s ${muscle}
>done

# Combinar todos los trees generados en un único archivo
cat *.treefile > Alltrees.tree
```

---

## Pruebas realizadas

* Se construyeron árboles filogenéticos individuales correspondientes a cada gen para poder analizarlos.
* Los archivos con extensión .tree fueron examinados utilizando el programa FigTree.
* Se llevaron a cabo alineamientos por separado para cada uno de los tres genes.

---

## Construido con

* [NCBI datasets](https://www.ncbi.nlm.nih.gov/datasets/)
* [muscle](https://www.drive5.com/muscle/)
* [iq-tree 2](http://www.iqtree.org/)
* [FigTree](http://tree.bio.ed.ac.uk/software/figtree/)
* [Atom](https://atom.io/)

---

## Autores

* **[Sol Yamileth Cueva Zambrano (SYCZ)]** — Encargada del análisis computacional y de la redacción del proyecto.

---

## Licencia

La presente iniciativa se realiza con objetivos educativos en el marco de la carrera de Biología – PUCE.

---

## Agradecimientos

* Al docente del curso de Bioinformática, Daniel Chávez, por su orientación y apoyo académico.
* A las plataformas de software libre empleadas en este proyecto, que permitieron llevar a cabo los análisis bioinformáticos de forma accesible y eficiente.

---

## Imagen del organismo

![Spheniscidae](https://datazone.darwinfoundation.org/images/checklist/5189_penguin_group_hms_ppt.jpg) 

