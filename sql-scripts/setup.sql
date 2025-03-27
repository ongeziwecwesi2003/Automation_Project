USE master;
GO

-- Stored procedure to create the database if it doesn't exist
CREATE OR ALTER PROCEDURE sp_CreateAutoDBJohn
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoDBJohn')
        BEGIN
            CREATE DATABASE AutoDBJohn;
            PRINT 'Database AutoDBJohn created.';
        END
        ELSE
        BEGIN
            PRINT 'Database AutoDBJohn already exists.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error creating database: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END;
GO

-- Execute the stored procedure
EXEC sp_CreateAutoDBJohn;
GO

-- Switch to the new database
BEGIN TRY
    USE AutoDBJohn;
    PRINT 'Switched to AutoDBJohn database.';
END TRY
BEGIN CATCH
    PRINT 'Error switching to AutoDBJohn: ' + ERROR_MESSAGE();
    RETURN;
END CATCH
GO

-- Create the user table if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'user')
BEGIN
    BEGIN TRY
        CREATE TABLE [user] (
            Name VARCHAR(50),
            Surname VARCHAR(50),
            Email VARCHAR(100)
        );
        PRINT 'Table [user] created.';
    END TRY
    BEGIN CATCH
        PRINT 'Error creating table: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO

-- Stored procedure to insert data
CREATE OR ALTER PROCEDURE sp_InsertUserData
AS
BEGIN
    BEGIN TRY
        INSERT INTO [user] (Name, Surname, Email)
        VALUES 
            ('John', 'Doe', 'john.doe@example.com'),
            ('Jane', 'Smith', 'jane.smith@example.com');
        PRINT 'Sample data inserted into user table.';
    END TRY
    BEGIN CATCH
        PRINT 'Error inserting data: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END;
GO

-- Execute the insert procedure
EXEC sp_InsertUserData;
GO
