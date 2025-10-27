/******************************************************************************
 * Script:      Create and Populate dbo.DimDate
 * Description: Creates a comprehensive Date Dimension table and populates it
 * with a specified date range. Includes fiscal columns and
 * BI-friendly attributes.
 * Author:      (Your Name/Team)
 * Date:        2025-10-26
 ******************************************************************************/

USE OLIST_DWH;

SET NOCOUNT ON;
SET DATEFIRST 7; -- Set Sunday = 7, Saturday = 6. This is the US_ENGLISH default.

BEGIN TRY
    BEGIN TRANSACTION;

    -- == 1. Configuration Variables ==
    -- Set the start and end dates for your dimension
    DECLARE @StartDate DATE = '2015-01-01';
    DECLARE @EndDate DATE = '2035-12-31';
    
    -- Set the starting month of your fiscal year (e.g., 1=Jan, 7=Jul)
    DECLARE @FiscalYearStartMonth TINYINT = 1; 


    -- == 2. Drop Table if it Exists (Optional) ==
    -- Use this if you need to completely rebuild the table
    IF OBJECT_ID('dbo.DWH_DimDate', 'U') IS NOT NULL
    BEGIN
        PRINT 'Dropping existing table dbo.DimDate...';
        DROP TABLE dbo.DWH_DimDate;
    END


    -- == 3. Create the Table Structure ==
    PRINT 'Creating table dbo.DimDate...';
    CREATE TABLE dbo.DWH_DimDate
    (
        [DateKey]              INT NOT NULL PRIMARY KEY, -- Example: 20251026
        [FullDate]             DATE NOT NULL,
        
        -- Calendar Attributes
        [DayOfMonth]           TINYINT NOT NULL,     -- 1-31
        [DayName]              NVARCHAR(10) NOT NULL,  -- 'Sunday', 'Monday'...
        [DayOfWeek]            TINYINT NOT NULL,     -- 1=Sunday, 2=Monday... (Based on SET DATEFIRST)
        [DayOfYear]            SMALLINT NOT NULL,    -- 1-366
        [WeekOfYear]           TINYINT NOT NULL,     -- 1-53
        [MonthName]            NVARCHAR(10) NOT NULL,  -- 'January', 'February'...
        [MonthOfYear]          TINYINT NOT NULL,     -- 1-12
        [Quarter]              TINYINT NOT NULL,     -- 1-4
        [Year]                 SMALLINT NOT NULL,    -- 2025
        
        -- Formatted Values
        [YearMonth]            NCHAR(7) NOT NULL,    -- '2025-01'
        [YearQuarter]          NCHAR(7) NOT NULL,    -- '2025-Q1'

        -- Fiscal Attributes
        [FiscalMonth]          TINYINT NOT NULL,
        [FiscalQuarter]        TINYINT NOT NULL,
        [FiscalYear]           SMALLINT NOT NULL,
        [FiscalPeriod]         NVARCHAR(10) NOT NULL, -- 'FY2025-Q1'

        -- Flags (Booleans)
        [IsWeekday]            BIT NOT NULL,
        [IsWeekend]            BIT NOT NULL,
        [IsFirstDayOfMonth]    BIT NOT NULL,
        [IsLastDayOfMonth]     BIT NOT NULL
    );

    -- Create a non-clustered index on the FullDate column for fast lookups
    CREATE UNIQUE INDEX IX_DimDate_FullDate ON dbo.DWH_DimDate(FullDate);


    -- == 4. Populate the "Unknown" Member ==
    -- This is a best practice for handling NULL dates in fact tables
    PRINT 'Inserting Unknown member...';
    INSERT INTO dbo.DWH_DimDate (
        [DateKey], [FullDate], 
        [DayOfMonth], [DayName], [DayOfWeek], [DayOfYear], [WeekOfYear], 
        [MonthName], [MonthOfYear], [Quarter], [Year],
        [YearMonth], [YearQuarter],
        [FiscalMonth], [FiscalQuarter], [FiscalYear], [FiscalPeriod],
        [IsWeekday], [IsWeekend], [IsFirstDayOfMonth], [IsLastDayOfMonth]
    )
    VALUES (
        -1, '1900-01-01',
        0, 'Unknown', 0, 0, 0, 
        'Unknown', 0, 0, 0,
        'N/A', 'N/A',
        0, 0, 0, 'N/A',
        0, 0, 0, 0
    );


    -- == 5. Generate and Insert Dates using a Recursive CTE ==
    PRINT 'Populating dates from ' + CONVERT(NVARCHAR, @StartDate) + ' to ' + CONVERT(NVARCHAR, @EndDate) + '...';

    ;WITH DateGenerator AS
    (
        -- Anchor Member: The starting date
        SELECT @StartDate AS FullDate
        
        UNION ALL
        
        -- Recursive Member: Add 1 day until the end date is reached
        SELECT DATEADD(day, 1, FullDate)
        FROM DateGenerator
        WHERE FullDate < @EndDate
    )
    -- Insert the generated dates and their attributes into the table
    INSERT INTO dbo.DWH_DimDate (
        [DateKey], [FullDate], 
        [DayOfMonth], [DayName], [DayOfWeek], [DayOfYear], [WeekOfYear], 
        [MonthName], [MonthOfYear], [Quarter], [Year],
        [YearMonth], [YearQuarter],
        [FiscalMonth], [FiscalQuarter], [FiscalYear], [FiscalPeriod],
        [IsWeekday], [IsWeekend], [IsFirstDayOfMonth], [IsLastDayOfMonth]
    )
    SELECT
        -- Primary Key (YYYYMMDD)
        CONVERT(INT, FORMAT(d.FullDate, 'yyyyMMdd')) AS [DateKey],
        d.FullDate AS [FullDate],
        
        -- Calendar Attributes
        DATEPART(day, d.FullDate) AS [DayOfMonth],
        DATENAME(weekday, d.FullDate) AS [DayName],
        DATEPART(weekday, d.FullDate) AS [DayOfWeek],
        DATEPART(dayofyear, d.FullDate) AS [DayOfYear],
        DATEPART(week, d.FullDate) AS [WeekOfYear],
        DATENAME(month, d.FullDate) AS [MonthName],
        DATEPART(month, d.FullDate) AS [MonthOfYear],
        DATEPART(quarter, d.FullDate) AS [Quarter],
        DATEPART(year, d.FullDate) AS [Year],

        -- Formatted Values
        FORMAT(d.FullDate, 'yyyy-MM') AS [YearMonth],
        CONCAT(DATEPART(year, d.FullDate), '-Q', DATEPART(quarter, d.FullDate)) AS [YearQuarter],

        -- Fiscal Attributes (Calculated based on @FiscalYearStartMonth)
        ( (DATEPART(month, d.FullDate) - @FiscalYearStartMonth + 12) % 12 ) + 1 AS [FiscalMonth],
        ( ( (DATEPART(month, d.FullDate) - @FiscalYearStartMonth + 12) % 12 ) / 3 ) + 1 AS [FiscalQuarter],
        CASE 
            WHEN DATEPART(month, d.FullDate) >= @FiscalYearStartMonth 
            THEN DATEPART(year, d.FullDate) + 1 
            ELSE DATEPART(year, d.FullDate) 
        END AS [FiscalYear],
        CONCAT(
            'FY',
            CASE 
                WHEN DATEPART(month, d.FullDate) >= @FiscalYearStartMonth 
                THEN DATEPART(year, d.FullDate) + 1 
                ELSE DATEPART(year, d.FullDate) 
            END,
            '-Q',
            ( ( (DATEPART(month, d.FullDate) - @FiscalYearStartMonth + 12) % 12 ) / 3 ) + 1
        ) AS [FiscalPeriod],

        -- Flags
        CASE WHEN DATEPART(weekday, d.FullDate) IN (2, 3, 4, 5, 6) THEN 1 ELSE 0 END AS [IsWeekday], -- Assumes Mon-Fri
        CASE WHEN DATEPART(weekday, d.FullDate) IN (1, 7) THEN 1 ELSE 0 END AS [IsWeekend], -- Assumes Sun, Sat
        CASE WHEN DATEPART(day, d.FullDate) = 1 THEN 1 ELSE 0 END AS [IsFirstDayOfMonth],
        CASE WHEN d.FullDate = EOMONTH(d.FullDate) THEN 1 ELSE 0 END AS [IsLastDayOfMonth]

    FROM DateGenerator AS d
    OPTION (MAXRECURSION 0); -- Set recursion to unlimited to handle large date ranges

    COMMIT TRANSACTION;
    
    PRINT 'Successfully created and populated dbo.DWH_DimDate.';
    PRINT 'Total rows inserted: ' + CONVERT(NVARCHAR, @@ROWCOUNT);

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    -- Raise the error
    PRINT 'Error occurred: ' + ERROR_MESSAGE();
    ;THROW; 
END CATCH;
GO

-- == 6. Verify the Data ==
SELECT TOP 10 * FROM dbo.DWH_DimDate
WHERE [Year] = 2024 AND [MonthOfYear] = 7; -- Check fiscal year transition

SELECT TOP 10 *
FROM dbo.DWH_DimDate
WHERE [DateKey] = -1; -- Check Unknown member
GO