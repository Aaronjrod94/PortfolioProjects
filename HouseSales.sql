Select *
From ZipCodes

Select *
From HouseSales

SELECT 
	YEAR([Month of Period End]) [Year]
From HouseSales

Select YEAR([Month of Period End]) [Year],
		ZipCodes.[Zip Code], 
		City, 
		County, 
		[Median Sale Price], 
		[Median Sale Price MoM ], 
		[Median Sale Price YoY ], 
		[Days on Market]
From ZipCodes
Left Join HouseSales
	ON ZipCodes.[Zip Code] = HouseSales.[Zip Code]
Where County IN ('Collin', 'Dallas', 'Denton','Ellis','Hunt','Kaufman','Rockwall')
Order by County, City, ZipCodes.[Zip Code], YEAR([Month of Period End])