-- ==========================================================
-- 1. Procédure de remplissage des employés (Dates 2065-2070)
-- ==========================================================
CREATE PROCEDURE SEED_DATA_WORKERS
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= 5
    BEGIN
        -- Dates aléatoires entre 2065 et 2070
        DECLARE @RandomDays INT = ABS(CHECKSUM(NEWID())) % 1825;
        DECLARE @StartDate DATE = DATEADD(day, @RandomDays, '2065-01-01');

        -- Insertion Usine 1 (Paris - avec Age)
        INSERT INTO WORKERS_FACTORY_1 (lastname, firstname, age, start_date)
        VALUES ('ParisNom' + CAST(@i AS VARCHAR), 'Jean' + CAST(@i AS VARCHAR), 20 + @i, @StartDate);

        -- Insertion Usine 2 (Caracas - sans Age)
        INSERT INTO WORKERS_FACTORY_2 (lastname, firstname, start_date)
        VALUES ('CaracasNom' + CAST(@i AS VARCHAR), 'Luis' + CAST(@i AS VARCHAR), @StartDate);

        SET @i = @i + 1;
    END
    PRINT 'SEED_DATA_WORKERS : 10 employés générés (5 par usine).';
END;
GO

-- ==========================================================
-- 2. Procédure de remplissage des pièces détachées
-- ==========================================================
CREATE PROCEDURE SEED_DATA_SPARE_PARTS
AS
BEGIN
    INSERT INTO SPARE_PARTS (name, supplier_id, quantity_delivered, robot_model_ref)
    VALUES 
    ('Capteur Optique', 1, 500, 'Vital Strider'),
    ('Batterie Lithium-Z', 4, 300, 'Alpha Bot'),
    ('Processeur IA', 5, 1000, 'Master Sentinel');
    PRINT 'SEED_DATA_SPARE_PARTS : Pièces insérées.';
END;
GO

-- ==========================================================
-- 3. Ajout d'un nouveau Robot
-- ==========================================================
CREATE PROCEDURE ADD_NEW_ROBOT
    @ModelName VARCHAR(100),
    @FactoryID INT,
    @Qty INT
AS
BEGIN
    INSERT INTO ROBOTS (model_name, factory_id, quantity, created_at)
    VALUES (@ModelName, @FactoryID, @Qty, GETDATE());
    PRINT 'Robot ' + @ModelName + ' ajouté avec succès.';
END;
GO