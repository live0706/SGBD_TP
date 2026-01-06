-- A. Création des Usines
INSERT INTO FACTORIES (id, name, location) VALUES (1, 'Usine Paris', 'Paris');
INSERT INTO FACTORIES (id, name, location) VALUES (2, 'Usine Caracas', 'Caracas');

-- B. Insertion des Fournisseurs (Basé sur fournisseurs.csv)
SET IDENTITY_INSERT SUPPLIERS ON;
INSERT INTO SUPPLIERS (id, name) VALUES (1, 'Optimux'), (2, 'Boston Mimics'), (3, 'Human Robotics'), (4, 'Tesla'), (5, 'Xiaomi');
SET IDENTITY_INSERT SUPPLIERS OFF;

-- C. Insertion des Employés (Basé sur intervenants.csv)
-- Paris (Avec Age)
INSERT INTO WORKERS_FACTORY_1 (lastname, firstname, age, start_date, end_date) VALUES ('Hurst', 'Alan', 61, '2014-03-01', '2014-05-07');
INSERT INTO WORKERS_FACTORY_1 (lastname, firstname, age, start_date, end_date) VALUES ('Buan', 'Sarah', 34, '2020-03-01', NULL);
INSERT INTO WORKERS_FACTORY_1 (lastname, firstname, age, start_date, end_date) VALUES ('Duran', 'Gael', 45, '2019-12-01', NULL);
INSERT INTO WORKERS_FACTORY_1 (lastname, firstname, age, start_date, end_date) VALUES ('Statham', 'Jason', 53, '2021-01-01', NULL);
-- Caracas (Sans Age)
INSERT INTO WORKERS_FACTORY_2 (lastname, firstname, start_date, end_date) VALUES ('Kelly', 'Floyd', '2002-06-01', '2003-01-22');
INSERT INTO WORKERS_FACTORY_2 (lastname, firstname, start_date, end_date) VALUES ('Mccormick', 'Robert', '2001-08-01', '2001-09-08');
INSERT INTO WORKERS_FACTORY_2 (lastname, firstname, start_date, end_date) VALUES ('Niney', 'Pierre', '2021-02-01', NULL);
INSERT INTO WORKERS_FACTORY_2 (lastname, firstname, start_date, end_date) VALUES ('Dujardin', 'Jean', '2021-02-01', NULL);

-- D. Insertion des Robots (Basé sur robots.csv)
INSERT INTO ROBOTS (model_name, factory_id, quantity, created_at) VALUES ('Vital Strider', 1, 29, '2020-01-01');
INSERT INTO ROBOTS (model_name, factory_id, quantity, created_at) VALUES ('Master Sentinel', 1, 14, '2020-01-01');
INSERT INTO ROBOTS (model_name, factory_id, quantity, created_at) VALUES ('Alpha Bot', 2, 60, '2020-02-01');
INSERT INTO ROBOTS (model_name, factory_id, quantity, created_at) VALUES ('Mega Man', 2, 22, '2020-02-01');

-- E. Insertion des Pièces (Basé sur fournisseurs.csv)
INSERT INTO SPARE_PARTS (name, supplier_id, quantity_delivered, robot_model_ref) VALUES ('bras droit', 1, 1500, 'Vital Strider');
INSERT INTO SPARE_PARTS (name, supplier_id, quantity_delivered, robot_model_ref) VALUES ('bras gauche', 2, 800, 'Vital Strider');
INSERT INTO SPARE_PARTS (name, supplier_id, quantity_delivered, robot_model_ref) VALUES ('torse', 3, 1200, 'Master Sentinel');
GO