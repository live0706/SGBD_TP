-- 1. GET_NB_WORKERS(factory_id INT) : renvoie le nombre de travailleurs dans une usine donnée (utilise ALL_WORKERS)
CREATE FUNCTION GET_NB_WORKERS (@FactoryId INT)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;
    SELECT @Total = COUNT(*) FROM ALL_WORKERS WHERE factory_id = @FactoryId;
    RETURN ISNULL(@Total, 0);
END;
GO

-- 2. GET_NB_BIG_ROBOTS() : compte le nombre de modèles de robots ayant reçu plus de 3 pièces (utilise SPARE_PARTS)
CREATE FUNCTION GET_NB_BIG_ROBOTS ()
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;
    SELECT @Total = COUNT(*)
    FROM (
        SELECT robot_model_ref, SUM(quantity_delivered) AS total_parts
        FROM SPARE_PARTS
        GROUP BY robot_model_ref
        HAVING SUM(quantity_delivered) > 3
    ) AS t;
    RETURN ISNULL(@Total, 0);
END;
GO

-- 3. GET_BEST_SUPPLIER() : renvoie le nom du fournisseur ayant livré le plus de pièces (utilise BEST_SUPPLIERS)
CREATE FUNCTION GET_BEST_SUPPLIER ()
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @SupplierName VARCHAR(100);
    SELECT TOP 1 @SupplierName = supplier FROM BEST_SUPPLIERS ORDER BY nb_parts DESC;
    RETURN @SupplierName;
END;
GO

-- 4. GET_OLDEST_WORKER() : renvoie l'ID du travailleur le plus ancien (start_date la plus ancienne)
CREATE FUNCTION GET_OLDEST_WORKER ()
RETURNS INT
AS
BEGIN
    DECLARE @WorkerID INT;
    SELECT TOP 1 @WorkerID = worker_id FROM ALL_WORKERS ORDER BY start_date ASC;
    RETURN @WorkerID;
END;
GO