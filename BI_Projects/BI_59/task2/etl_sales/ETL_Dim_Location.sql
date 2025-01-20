INSERT INTO BI_BikesDW_59.Dim_Location (LocationKey, Country, Region, TaxRate, ShipCoeff)
SELECT 
    CountryID AS LocationKey,
    Country,
    Region,
    TaxRate,
    ShipCoeff
FROM BI_Bikes_59.TB_Country;