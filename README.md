# Análisis evolutivo filogenéticamente entre genes equivalentes de la familia Spheniscidae

Este proyecto tiene como objetivo reconstruir la historia evolutiva de pingüinos de la familia Spheniscidae mediante el análisis de tres genes ortólogos mitocondriales (ND1 y CYTB), las cuales, se obtuvieron de la base de datos NCBI.

---

## En primera instancia

Este documento proporciona los pasos necesarios para ejecutar el análisis filogenético en una supercomputadora, comenzando con la descarga de secuencias y finalizando con la visualización de los árboles, para luego comenzar con el análisis evolutivo. Además, se involucrara un grupo externo (Alcidae), para poder ver su relación con Spheniscidae.
---

## Prerrequisitos

* Contar con acceso a una supercomputadora.
* Tener disponible una terminal o Git Bash.
* Disponer de los siguientes programas instalados en el ordenador y en una carpeta propia de la supercomputadora:
  * `esearch` de NCBI para la descarga de secuencias biomédicas.
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

# 4. Crear una carpeta de trabajo

mkdir IDEA-DE-PROYECTO2

---

## Creación de un bash 

Se creo un bash en el cual se descargaron las secuencias de los genes ND1 y CYTB, de las dos familias correspondientes, Spheniscidae (30 secuencias ya que era un gen muy pesado en esta familia) y Alcidae (Una secuencia). Luego se transformaron en fasta y se editaron con atom directamente para que solo salga el numero de secuencia y el nombre científico.
Posteriormente, se unieron las dos fastas en una sola y se alinearon con muscle, y se ejecutaron con IQ-TREE. Finalmente al tener todos los tres, se unieron en un cat de nombre Alltrees.tree, para poder ver la filogenia en la herramienta de FigTree.

* Todo el proceso del bash se encuentra en el encabezado SCRIPT.

---

## Resultados 

**Tree 1 - Gen ND1**

![Tree 1](Tree1(ND1).jpeg)

- El árbol filogenético muestra la relación evolutiva entre especies de pingüinos y un grupo externo (Uria lomvia) del gen ND1. Se observan agrupaciones claras por género: Pygoscelis papua forma un clado monofilético con alta variabilidad intraespecífica; P. adeliae y P. antarcticus están cercanamente relacionados. Aptenodytes y Spheniscus también forman clados separados, reflejando su divergencia evolutiva. El uso de Uria lomvia como outgroup permite enraizar el árbol y evidenciar la separación entre pingüinos y otras aves marinas.

**Tree 2 - Gen CYTB**

![Tree 1](Tree2(CYTB).jpeg)

- Este árbol filogenético del gen CYTB, confirma la agrupación esperada de especies dentro de los géneros Pygoscelis, Spheniscus y Eudyptes, pero muestra una separación inesperada entre las especies de Aptenodytes, posiblemente por diferencias en la secuencia usada; también emplea una secuencia de cytochrome b como grupo externo artificial.

---

## Construido con

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

**Familia Spheniscidae**

![Spheniscidae](https://datazone.darwinfoundation.org/images/checklist/5189_penguin_group_hms_ppt.jpg) 

**Familia Alcidae**

![Alcidae](https://deanimalia.com/images/full/regionespolares/frailecillo2.jpg) 
