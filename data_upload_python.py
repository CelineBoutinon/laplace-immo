{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "2e425d99",
   "metadata": {},
   "outputs": [],
   "source": [
    "# import librairies needed for project\n",
    "import numpy as np\n",
    "import pandas as pd\n",
    "import mysql.connector as connector\n",
    "from mysql.connector import Error\n",
    "from datetime import datetime\n",
    "\n",
    "# initiate connection to database\n",
    "# check & replace connection options based on your local settings\n",
    "try:\n",
    "    connection = connector.connect(\n",
    "    host=\"127.0.0.1\",\n",
    "    port=3306,\n",
    "    user=\"root\",\n",
    "    password=\"1234\",\n",
    "    auth_plugin='mysql_native_password',\n",
    "    database=\"dataimmo\",\n",
    "    autocommit=True)\n",
    "    if connection.is_connected():\n",
    "        print(\"Connection to dataimmo database successful !\")\n",
    "        \n",
    "except Error as e:\n",
    "    print(\"Error while connecting to dataimmo database\", e)\n",
    "\n",
    "\n",
    "# create a cursor instance\n",
    "cursor = connection.cursor()\n",
    "\n",
    "\n",
    "# import data files - these must be saved in the same directory as this Jupyter notebook otherwise the import will fail\n",
    "# for each file, display size (lines & columns) - check in MySQL workbench that all lines have been imported by calling\n",
    "# SELECT * FROM <table_name> # on the relevant table after import or checking the import message in the output panel in\n",
    "# MySQL Workbench\n",
    "bien = pd.read_csv('bien.csv', encoding='latin-1')\n",
    "print(\"Le fichier bien.csv comporte\", bien.shape[0],\"lignes et\", bien.shape[1],\" colonnes.\")\n",
    "commune =  pd.read_csv('commune.csv', encoding='latin-1')\n",
    "print(\"Le fichier commune.csv comporte\", commune.shape[0],\"lignes et\", commune.shape[1],\" colonnes.\")\n",
    "departement = pd.read_csv('departement.csv', encoding='latin-1')\n",
    "print(\"Le fichier departement.csv comporte\", departement.shape[0],\"lignes et\", departement.shape[1],\" colonnes.\")\n",
    "mutation = pd.read_csv('mutation.csv', encoding='latin-1')\n",
    "print(\"Le fichier mutation.csv comporte\", mutation.shape[0],\"lignes et\", mutation.shape[1],\" colonnes.\")\n",
    "ref_dep = pd.read_csv('ref_dep.csv', encoding='latin-1')\n",
    "print(\"Le fichier ref_dep.csv comporte\", ref_dep.shape[0],\"lignes et\", ref_dep.shape[1],\" colonnes.\")\n",
    "region = pd.read_csv('region.csv', encoding='latin-1')\n",
    "print(\"Le fichier region.csv comporte\", region.shape[0],\"lignes et\", region.shape[1],\" colonnes.\")\n",
    "\n",
    "# rename columns to get rid of some UTF8 decoding issues\n",
    "bien.rename(columns={'ï»¿com_code': 'com_code'}, inplace=True)\n",
    "departement.rename(columns={'ï»¿dep_code': 'dep_code'}, inplace=True)\n",
    "mutation.rename(columns={'ï»¿No disposition': 'mut_numdisp', 'Date mutation':'mut_date','Nature mutation':'mut_type','Valeur fonciere':'mut_val'}, inplace=True)\n",
    "\n",
    "# change format date column to MySQL standard format\n",
    "mutation.mut_date = pd.to_datetime(mutation.mut_date, format='%d/%m/%Y').dt.strftime('%Y-%m-%d')\n",
    "\n",
    "# reorder columns to match database\n",
    "bien_final = bien[['bien_id', 'com_code', 'bien_type', 'bien_carrez_1','bien_surfbat','bien_numpieces']].copy()\n",
    "commune_final = commune[['com_code', 'dep_code', 'com_nom', 'com_poptot']].copy()\n",
    "departement_final = departement.copy()\n",
    "mutation_final = mutation[['bien_id','mut_date','mut_numdisp','mut_type','mut_val']].copy()\n",
    "ref_dep_final = ref_dep.copy()\n",
    "region_final = region.copy()\n",
    "\n",
    "# export data files to .csv file in location accessible to MySQL workbench - the path may differ on your own computer\n",
    "bien_final.to_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bien.csv', index=False, encoding='latin_1')\n",
    "commune_final.to_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/commune.csv', index=False, encoding='latin_1')\n",
    "departement_final.to_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/departement.csv', index=False, encoding='latin_1')\n",
    "mutation_final.to_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mutation.csv', index=False, encoding='latin_1')\n",
    "ref_dep_final.to_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ref_dep.csv', index=False, encoding='latin_1')\n",
    "region_final.to_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/region.csv', index=False, encoding='latin_1')\n",
    "\n",
    "\n",
    "# create MySQL statements to upload each .csv file into the relevant database table\n",
    "load_bien = \"LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bien.csv' INTO TABLE bien CHARACTER SET latin1 FIELDS TERMINATED BY ',' IGNORE 1 ROWS\"\n",
    "load_commune = \"LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/commune.csv' INTO TABLE commune CHARACTER SET latin1 FIELDS TERMINATED BY ',' IGNORE 1 ROWS\"\n",
    "load_departement = \"LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/departement.csv' INTO TABLE departement CHARACTER SET latin1 FIELDS TERMINATED BY ',' IGNORE 1 ROWS\"\n",
    "load_mutation = \"LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mutation.csv' INTO TABLE mutation CHARACTER SET latin1 FIELDS TERMINATED BY ',' IGNORE 1 ROWS\"\n",
    "load_ref_dep = \"LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ref_dep.csv' INTO TABLE ref_dep CHARACTER SET latin1 FIELDS TERMINATED BY ',' IGNORE 1 ROWS\"\n",
    "load_region = \"LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/region.csv' INTO TABLE region CHARACTER SET latin1 FIELDS TERMINATED BY ',' IGNORE 1 ROWS\"\n",
    "\n",
    "\n",
    "# set foreign key checks to FALSE (so the order in which you import tables is irrelevant)\n",
    "cursor.execute(\"SET FOREIGN_KEY_CHECKS=0\")\n",
    "\n",
    "# execute data upload statements (no need for a COMMIT statement as we set the autocommit option to TRUE when establishing\n",
    "# the connection)\n",
    "cursor.execute(load_region)\n",
    "cursor.execute(load_ref_dep)\n",
    "cursor.execute(load_departement)\n",
    "cursor.execute(load_commune)\n",
    "cursor.execute(load_bien)\n",
    "cursor.execute(load_mutation)\n",
    "\n",
    "# set foreign key checks back to TRUE\n",
    "cursor.execute(\"SET FOREIGN_KEY_CHECKS=1\")\n",
    "\n",
    "# close the connection\n",
    "connection.close()\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.9.13"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
