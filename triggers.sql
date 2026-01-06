-- ==========================================================
-- Trigger d'Audit : Enregistre chaque nouveau robot
-- ==========================================================
CREATE TRIGGER trg_AfterRobotInsert
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