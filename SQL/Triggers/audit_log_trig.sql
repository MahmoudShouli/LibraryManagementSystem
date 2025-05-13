DROP TRIGGER IF EXISTS trg_AuditLogUpdate;
GO

CREATE TRIGGER trg_AuditLogUpdate
ON Books
AFTER UPDATE
AS
BEGIN
	IF UPDATE(Current_Status)
	BEGIN
		INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
		SELECT 
			BookID,
			'To ' + Current_Status,
			GETDATE()
		FROM inserted;
	END
END


/* usage

SELECT * FROM AuditLog;

UPDATE Books
SET Current_Status =  'Available'
WHERE BookID = 1;

SELECT * FROM AuditLog;

*/