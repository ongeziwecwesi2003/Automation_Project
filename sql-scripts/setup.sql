USE master;
GO

-- Create the database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTest')
BEGIN
    BEGIN TRY
        CREATE DATABASE AutoTest;
        PRINT 'Database AutoTest created.';
    END TRY
    BEGIN CATCH
        PRINT 'Error creating database: ' + ERROR_MESSAGE();
        RETURN; -- Stop execution if database creation fails
    END CATCH
END
GO

-- Switch to AutoTest database
BEGIN TRY
    USE AutoTest;
    PRINT 'Switched to AutoTest database.';
END TRY
BEGIN CATCH
    PRINT 'Error switching to AutoTest: ' + ERROR_MESSAGE();
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

-- Create or alter the stored procedure
BEGIN TRY
    EXEC('CREATE OR ALTER PROCEDURE InsertUser
    AS
    BEGIN
        INSERT INTO [user] (Name, Surname, Email)
        VALUES 
            (''John'', ''Doe'', ''john.doe@example.com''),
            (''Ongeziwe'', ''Cwesi'', ''ongeziwecwesi@gmail.com''),
            (''Jane'', ''Smith'', ''jane.smith@example.com'');
        PRINT ''Sample data inserted.'';
    END');
    PRINT 'Stored procedure InsertUser created/altered.';
END TRY
BEGIN CATCH
    PRINT 'Error creating stored procedure: ' + ERROR_MESSAGE();
    RETURN;
END CATCH
GO

-- Execute the stored procedure
BEGIN TRY
    EXEC InsertUser;
    PRINT 'InsertUser executed.';
END TRY
BEGIN CATCH
    PRINT 'Error executing InsertUser: ' + ERROR_MESSAGE();
END CATCH
GO
