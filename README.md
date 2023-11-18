
![Alt text](LaplaceLogoSmall.png)


# REALISER UNE BASE DE DONNEES IMMOBILIERES AVEC MYSQL

Projet realisé en janvier 2023 dans le cadre de ma formation Data Analyst avec OpenClassrooms.

## Objectif du projet
***
Ce projet a pour objectif de constituer une base de données immobilières en croisant des données issues de plusieurs sources publiques françaises, à savoir le fichier des demandes de valeurs foncières, le référentiel géographique des régions et le fichier des recensements de population de l’INSEE.
Ces fichiers, qui sont disponibles en accès libre sur les différents sites publics du gouvernement, ainsi que leurs notices d’interprétation, sont évidemment très lourds, comportant de nombreux champs de données qu’il a donc fallu interpréter pour prendre la décision (ou non) de leur inclusion dans la base de données (voir dossier « données brutes » pour les fichiers sources utilisés pour ce projet et le dictionnaire des données pour la liste des colonnes incluses dans la base).
L’objet des notes de présentation jointes à ce projet est donc de :
* présenter les démarches qui ont présidé à la création de cette base, tout d’abord en présentant les différentes données choisies au travers du dictionnaire de données, et en montrant comment ces différentes données sont reliées entre-elles et ont été organisées au travers du schéma relationnel de la base ;
* décrire les outils et méthodes choisis pour l’implémentation de la base, depuis les vérifications effectuées sur la qualité des données jusqu’à leur import dans la base, en passant par leur formatage ; et
* présenter les différents résultats des requêtes construites et les problématiques auxquelles elles répondent, après avoir rappelé les principes génériques qui ont guidé la création de ces requêtes dans MySQL.


## Liste des dossiers & fichiers
***
* **dossiers :**
  - **donnees-brutes :** fichiers téléchargés depuis les sources (format .xlsx)
  - **donnees-nettoyees :** fichiers prêts à alimenter la base (format .csv)
  - **donnees-dot-gouv-dot-fr :** fichiers explicatifs pour le contenu des différentes colonnes des données brutes
  - **requetes :** scripts pour interroger la base dans MySQL (format .sql)


* **fichiers :**
	- **creation_script.sql :** script de création de la base de données, des tables et des clés
	- **schema.mwb :** schéma relationnel de la base MySQL
	- **data_upload_Python_script.ipynb :** code Python permettant l'import des fichiers .csv dans la base de données MySQL
	- **dico_donnees :** dictionnaire des données présentes dans la base MySQL
	- **resultats_requetes.xlsx :** résultats des scripts d'interrogation de la base
    - **presentation.pdf :** diapositives de présentation du projet
    - **presentation_notes.pdf :** notes d’accompagnement des diapositives de présentation du projet


## Compétences développées
***
* Effectuer des requêtes SQL pour répondre à une problématique métier
* Créer des tables dans une base de données
* Charger des données dans une base de données
* Mettre à jour un catalogue de données
* Créer le schéma d'une base de données



## Langages & software
***
* Excel / PowerQuery
* MySQL / MySQL Workbench
* Python / Pandas / MySQL Connector
* Jupyter Notebook








