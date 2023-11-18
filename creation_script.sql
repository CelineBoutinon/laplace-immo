CREATE DATABASE dataimmo ;

CREATE TABLE REGION (
                reg_code VARCHAR(2) NOT NULL,
                reg_nom VARCHAR(50),
                PRIMARY KEY (reg_code)
);

CREATE TABLE DEPARTEMENT (
                dep_code VARCHAR(3) NOT NULL,
                reg_code VARCHAR(2) NOT NULL,
                PRIMARY KEY (dep_code)
);


CREATE TABLE REF_DEP (
                ref_dep_code VARCHAR(3) NOT NULL,
                ref_dep_nom VARCHAR(50),
                PRIMARY KEY (ref_dep_code)
);


CREATE TABLE COMMUNE (
                com_code VARCHAR(6) NOT NULL,
                dep_code VARCHAR(3) NOT NULL,
                com_nom VARCHAR(50),
                com_poptot INT,
                PRIMARY KEY (com_code)
);


CREATE TABLE BIEN (
                bien_id VARCHAR(15) NOT NULL,
                com_code VARCHAR(6) NOT NULL,
                bien_type VARCHAR(50),
                bien_carrez_1 FLOAT,
                bien_surfbat FLOAT,
                bien_numpieces INT,
                PRIMARY KEY (bien_id)
);


CREATE TABLE MUTATION (
                bien_id VARCHAR(15) NOT NULL,
                mut_date DATE NOT NULL,
                mut_numdisp INT NOT NULL,
                mut_type VARCHAR(10),
                mut_val FLOAT,
                PRIMARY KEY (bien_id, mut_date, mut_numdisp)
);

ALTER TABLE DEPARTEMENT ADD CONSTRAINT region_departement_fk
FOREIGN KEY (reg_code)
REFERENCES REGION (reg_code)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE COMMUNE ADD CONSTRAINT departement_commune_fk
FOREIGN KEY (dep_code)
REFERENCES DEPARTEMENT (dep_code)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE REF_DEP ADD CONSTRAINT departement_ref_dept_fk
FOREIGN KEY (ref_dep_code)
REFERENCES DEPARTEMENT (dep_code)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE BIEN ADD CONSTRAINT commune_bien_fk
FOREIGN KEY (com_code)
REFERENCES COMMUNE (com_code)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE MUTATION ADD CONSTRAINT bien_transaction_fk
FOREIGN KEY (bien_id)
REFERENCES BIEN (bien_id)
ON DELETE CASCADE
ON UPDATE CASCADE;
