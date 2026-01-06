CREATE TRIGGER TRG_ALL_WORKERS_ELAPSED_IOT
ON ALL_WORKERS_ELAPSED
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        IF EXISTS (SELECT 1 FROM deleted)
        BEGIN
            RAISERROR('L''opération UPDATE n''est pas autorisée sur cette vue', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        ELSE
        BEGIN
            INSERT INTO WORKERS_FACTORY_1 (lastname, firstname, age, start_date)
            SELECT lastname, firstname, age, start_date
            FROM inserted
            WHERE age IS NOT NULL;
            
            INSERT INTO WORKERS_FACTORY_2 (lastname, firstname, start_date)
            SELECT lastname, firstname, start_date
            FROM inserted
            WHERE age IS NULL;
        END
    END
    ELSE
    BEGIN
        RAISERROR('L''opération DELETE n''est pas autorisée sur cette vue', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

CREATE TRIGGER TRG_ROBOT_AUDIT
ON ROBOTS
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO AUDIT_ROBOT (robot_id, created_at)
    SELECT id, GETDATE()
    FROM inserted;
END;
GO

CREATE TRIGGER TRG_ROBOTS_FACTORIES_VALIDATION
ON ROBOTS_FACTORIES
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @factory_count INT;
    DECLARE @table_count INT;
    
    SELECT @factory_count = COUNT(*) FROM FACTORIES;
    
    SELECT @table_count = COUNT(*)
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME LIKE 'WORKERS_FACTORY_%';
    
    IF @factory_count <> @table_count
    BEGIN
        RAISERROR('Le nombre d''usines ne correspond pas au nombre de tables WORKERS_FACTORY_<N>', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        IF EXISTS (SELECT 1 FROM deleted)
        BEGIN
            RAISERROR('L''opération UPDATE n''est pas supportée via cette vue', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        ELSE
        BEGIN
            RAISERROR('L''opération INSERT n''est pas supportée via cette vue', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END
    ELSE
    BEGIN
        RAISERROR('L''opération DELETE n''est pas supportée via cette vue', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

CREATE TRIGGER TRG_WORKER_END_DATE_FACTORY_1
ON WORKERS_FACTORY_1
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE(end_date)
    BEGIN
        UPDATE WORKERS_FACTORY_1
        SET duration_days = DATEDIFF(DAY, start_date, end_date)
        FROM WORKERS_FACTORY_1 w
        INNER JOIN inserted i ON w.id = i.id
        WHERE i.end_date IS NOT NULL;
    END
END;
GO

CREATE TRIGGER TRG_WORKER_END_DATE_FACTORY_2
ON WORKERS_FACTORY_2
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE(end_date)
    BEGIN
        UPDATE WORKERS_FACTORY_2
        SET duration_days = DATEDIFF(DAY, start_date, end_date)
        FROM WORKERS_FACTORY_2 w
        INNER JOIN inserted i ON w.id = i.id
        WHERE i.end_date IS NOT NULL;
    END
END;
GO