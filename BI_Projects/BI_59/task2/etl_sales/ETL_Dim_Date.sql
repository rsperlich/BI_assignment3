INSERT INTO BI_BikesDW_59.Dim_Date (DateKey, FullDateAlternateKey, DayNumberOfWeek, EnglishDayNameOfWeek, DayNumberOfMonth, DayNumberOfYear, WeekNumberOfYear, EnglishMonthName, MonthNumberOfYear, CalendarQuarter, CalendarYear)
SELECT 
    YEAR(OrderDate) * 10000 + MONTH(OrderDate) * 100 + DAY(OrderDate) AS DateKey,
    OrderDate AS FullDateAlternateKey,
    DAYOFWEEK(OrderDate) AS DayNumberOfWeek,
    DAYNAME(OrderDate) AS EnglishDayNameOfWeek,
    DAY(OrderDate) AS DayNumberOfMonth,
    DAYOFYEAR(OrderDate) AS DayNumberOfYear,
    WEEK(OrderDate, 1) AS WeekNumberOfYear,
    MONTHNAME(OrderDate) AS EnglishMonthName,
    MONTH(OrderDate) AS MonthNumberOfYear,
    QUARTER(OrderDate) AS CalendarQuarter,
    YEAR(OrderDate) AS CalendarYear
FROM BI_Bikes_59.TB_SalesOrderHeader
GROUP BY OrderDate;

INSERT INTO BI_BikesDW_59.Dim_Date (DateKey, FullDateAlternateKey, DayNumberOfWeek, EnglishDayNameOfWeek, DayNumberOfMonth, DayNumberOfYear, WeekNumberOfYear, EnglishMonthName, MonthNumberOfYear, CalendarQuarter, CalendarYear)
SELECT 
    YEAR(DueDate) * 10000 + MONTH(DueDate) * 100 + DAY(DueDate) AS DateKey,
    DueDate AS FullDateAlternateKey,
    DAYOFWEEK(DueDate) AS DayNumberOfWeek,
    DAYNAME(DueDate) AS EnglishDayNameOfWeek,
    DAY(DueDate) AS DayNumberOfMonth,
    DAYOFYEAR(DueDate) AS DayNumberOfYear,
    WEEK(DueDate, 1) AS WeekNumberOfYear,
    MONTHNAME(DueDate) AS EnglishMonthName,
    MONTH(DueDate) AS MonthNumberOfYear,
    QUARTER(DueDate) AS CalendarQuarter,
    YEAR(DueDate) AS CalendarYear
FROM BI_Bikes_59.TB_SalesOrderHeader soh
WHERE DueDate IS NOT NULL 
AND NOT EXISTS (
        SELECT 1 
        FROM BI_BikesDW_59.Dim_Date dd
        WHERE dd.FullDateAlternateKey = soh.DueDate 
    )
GROUP BY DueDate;


INSERT INTO BI_BikesDW_59.Dim_Date (DateKey, FullDateAlternateKey, DayNumberOfWeek, EnglishDayNameOfWeek, DayNumberOfMonth, DayNumberOfYear, WeekNumberOfYear, EnglishMonthName, MonthNumberOfYear, CalendarQuarter, CalendarYear)
SELECT 
    YEAR(ShipDate) * 10000 + MONTH(ShipDate) * 100 + DAY(ShipDate) AS DateKey,
    ShipDate AS FullDateAlternateKey,
    DAYOFWEEK(ShipDate) AS DayNumberOfWeek,
    DAYNAME(ShipDate) AS EnglishDayNameOfWeek,
    DAY(ShipDate) AS DayNumberOfMonth,
    DAYOFYEAR(ShipDate) AS DayNumberOfYear,
    WEEK(ShipDate, 1) AS WeekNumberOfYear,
    MONTHNAME(ShipDate) AS EnglishMonthName,
    MONTH(ShipDate) AS MonthNumberOfYear,
    QUARTER(ShipDate) AS CalendarQuarter,
    YEAR(ShipDate) AS CalendarYear
FROM BI_Bikes_59.TB_SalesOrderHeader soh
WHERE ShipDate IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 
        FROM BI_BikesDW_59.Dim_Date dd
        WHERE dd.FullDateAlternateKey= soh.ShipDate
        )
GROUP BY ShipDate;
