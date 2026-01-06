-- 1. Tables des Usines
CREATE TABLE FACTORIES (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

-- 2. Usine Paris (AVEC la colonne Age) [cite: 36]
CREATE TABLE WORKERS_FACTORY_1 (
    id INT IDENTITY(1,1) PRIMARY KEY,
    lastname VARCHAR(100),
    firstname VARCHAR(100),
    age INT, 
    start_date DATE,
    end_date DATE,
    duration_days INT -- Demandé par le Trigger 4
);

-- 3. Usine Caracas (SANS la colonne Age) [cite: 37]
CREATE TABLE WORKERS_FACTORY_2 (
    id INT IDENTITY(1,1) PRIMARY KEY,
    lastname VARCHAR(100),
    firstname VARCHAR(100),
    start_date DATE,
    end_date DATE,
    duration_days INT -- Demandé par le Trigger 4
);

-- 4. Fournisseurs
CREATE TABLE SUPPLIERS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100)
);

-- 5. Robots (Production)
CREATE TABLE ROBOTS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    model_name VARCHAR(100),
    factory_id INT FOREIGN KEY REFERENCES FACTORIES(id),
    quantity INT, -- Ajouté pour coller à vos données Excel
    created_at DATETIME DEFAULT GETDATE()
);

-- 6. Pièces Détachées
CREATE TABLE SPARE_PARTS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    supplier_id INT FOREIGN KEY REFERENCES SUPPLIERS(id),
    quantity_delivered INT,
    robot_model_ref VARCHAR(100) -- Pour lier au modèle de robot
);

-- 7. Audit (Requis par Trigger 2)
CREATE TABLE AUDIT_ROBOT (
    id INT IDENTITY(1,1) PRIMARY KEY,
    robot_id INT,
    created_at DATETIME DEFAULT GETDATE()
);
GO