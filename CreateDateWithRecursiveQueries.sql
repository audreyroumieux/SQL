
-- https://blog.pengoworks.com/index.cfm/2009/1/8/Dynamically-generating-a-table-of-dates-in-Microsoft-SQL-Part-Deux

DECLARE @StartDate date = '2015-01-01'; --DATETIME = GETDATE();
/*
DECLARE @IntervalType VARCHAR(15);
@Num INT =0;
DECLARE @EndDate DATETIME = CASE @IntervalType
        WHEN 'DAY' THEN DATEADD(DAY,@Num,@StartDate)
        WHEN 'MONTH' THEN DATEADD(MONTH,@Num,@StartDate)
        WHEN 'YEAR' THEN DATEADD(YEAR,@Num,@StartDate)
    END;
*/
DECLARE @EndDate date = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()),0)

;WITH DateSerial AS
(
	SELECT @StartDate AS MonthDate
	UNION ALL
	SELECT DATEADD(MONTH, 1, MonthDate)
	FROM DateSerial
	WHERE MonthDate < @EndDate --DATEDIFF(DAY, @StartDate, @EndDate)
)

SELECT * FROM DateSerial
--ORDER BY MonthDate
OPTION (MAXRECURSION 0);


