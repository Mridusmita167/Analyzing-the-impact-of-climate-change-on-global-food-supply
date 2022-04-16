-- Average Production of various crops

Select * From [PortfolioProject 3]..['key-crop-yields']
order by Entity


--where Entity not in ('Asia', 'Africa', 'Asia, Central', 'Central America', 'Eastern Africa', 'Central African Republic', 'Eastern Asia',
--'Eastern Europe', 'Europe', 'Europe, Western', 'Middle Africa', 'Land Locked Developing countries', 'Least Developed Countries', 'Low Income Food Deficit Countries',
--'Net Food Importing Developing Countries', 'Northern Africa', 'Northern America', 'Northern Europe', 'Pacific Islands Trust Territory', 'European Union',
--'Australia & New Zealand', 'South America', 'South eastern Asia', 'Southern Africa', 'Southern Asia', 'Southerrn Europe', 'Western Africa', 'Western Asia', 'World')

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--Looking at the number of countries 
Select Distinct(Count(Entity)) From [PortfolioProject 3]..['key-crop-yields']
where Entity not in ('Asia', 'Africa', 'Asia, Central', 'Central America', 'Eastern Africa', 'Central African Republic', 'Eastern Asia',
'Eastern Europe', 'Europe', 'Europe, Western', 'Middle Africa', 'Land Locked Developing countries', 'Least Developed Countries', 'Low Income Food Deficit Countries',
'Net Food Importing Developing Countries', 'Northern Africa', 'Northern America', 'Northern Europe', 'Pacific Islands Trust Territory', 'European Union',
'Australia & New Zealand', 'South America', 'South eastern Asia', 'Southern Africa', 'Southern Asia', 'Southerrn Europe', 'Western Africa', 'Western Asia', 'World')
---------------------------------------------------------------------------------------------------------------------------------------------------------------

--Looking at highest production of various crops in each country
Select Entity, MAX([Wheat_hg/ha]) as Wheat, Max([Rice_hg/ha]) as Rice, MAX([Maize_hg/ha]) as Maize, MAX([Soybeans_hg/ha]) as Soybeans, 
MAX([Potatoes_hg/ha]) as Potatoes, MAX([Beans_hg/ha]) as Beans, MAX([Peas_hg/ha]) as Peas, MAX([Cassava_hg/ha]) as Cassava, MAX([Barley_hg/ha]) as Barley,
MAX([Cocoa_hg/ha]) as Cocoa, MAX([Bananas_hg/ha]) as Bananas
From [PortfolioProject 3]..['key-crop-yields']
group by Entity
order by Entity


---------------------------------------------------------------------------------------------------------------------------------------------------------------

--Looking at the maximum production of each type of crop and in which year
Select Year, MAX([Wheat_hg/ha]) as Wheat, Max([Rice_hg/ha]) as Rice, MAX([Maize_hg/ha]) as Maize, MAX([Soybeans_hg/ha]) as Soybeans, 
MAX([Potatoes_hg/ha]) as Potatoes, MAX([Beans_hg/ha]) as Beans, MAX([Peas_hg/ha]) as Peas, MAX([Cassava_hg/ha]) as Cassava, MAX([Barley_hg/ha]) as Barley,
MAX([Cocoa_hg/ha]) as Cocoa, MAX([Bananas_hg/ha]) as Bananas
From [PortfolioProject 3]..['key-crop-yields']
group by Year
order by Year


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Looking at the Highest Production of Rice in each Country
Select Entity, 
		Max([Rice_hg/ha]) as Rice 
From [PortfolioProject 3]..['key-crop-yields']
Group by Entity
Order By Rice desc
--Australia


---------------------------------------------------------------------------------------------------------------------------------------------------------------

--Looking for the Highest Production of Wheat in each country
Select Entity, 
		MAX([Wheat_hg/ha]) as Wheat
From [PortfolioProject 3]..['key-crop-yields']
Group By Entity
Order By Wheat desc
--Ireland

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--Looking for Highest Producer of Rice each year
With HighestRiceProducer as
(Select Entity, 
		Year, 
		MAX([Rice_hg/ha]) as RiceYield,
		RANK() OVER(PARTITION BY Year ORDER BY MAX([Rice_hg/ha]) desc) Rank
From [PortfolioProject 3]..['key-crop-yields']
where Entity not in ('Asia', 'Africa', 'Asia, Central', 'Central America', 'Eastern Africa', 'Central African Republic', 'Eastern Asia',
'Eastern Europe', 'Europe', 'Europe, Western', 'Middle Africa', 'Land Locked Developing countries', 'Least Developed Countries', 'Low Income Food Deficit Countries',
'Net Food Importing Developing Countries', 'Northern Africa', 'Northern America', 'Northern Europe', 'Pacific Islands Trust Territory', 'European Union',
'Australia & New Zealand', 'South America', 'South eastern Asia', 'Southern Africa', 'Southern Asia', 'Southerrn Europe', 'Western Africa', 'Western Asia', 'World')
Group By Year, Entity)

Select * From HighestRiceProducer
where Rank = 1
Order By Year

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--Looking for Highest Producer of Wheat each Year
With HighestWheatProducer as
(Select Entity, 
		Year, 
		MAX([Wheat_hg/ha]) as WheatYield,
		RANK() OVER(PARTITION BY Year ORDER BY MAX([Wheat_hg/ha]) desc) Rank
From [PortfolioProject 3]..['key-crop-yields']
where Entity not in ('Asia', 'Africa', 'Asia, Central', 'Central America', 'Eastern Africa', 'Central African Republic', 'Eastern Asia',
'Eastern Europe', 'Europe', 'Europe, Western', 'Middle Africa', 'Land Locked Developing countries', 'Least Developed Countries', 'Low Income Food Deficit Countries',
'Net Food Importing Developing Countries', 'Northern Africa', 'Northern America', 'Northern Europe', 'Pacific Islands Trust Territory', 'European Union',
'Australia & New Zealand', 'South America', 'South eastern Asia', 'Southern Africa', 'Southern Asia', 'Southerrn Europe', 'Western Africa', 'Western Asia', 'World')
Group By Year, Entity)

Select * From HighestWheatProducer
where Rank = 1
Order By Year

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--Looking at the Rice Yield dataset
Select Entity, 
		Max([Rice yield-hg/ha]) as Rice 
From [PortfolioProject 3]..['rice-yields']
Group by Entity
Order By Rice desc
--UAE

With HighestRiceProduction as
(Select Entity, 
		Year, 
		MAX([Rice yield-hg/ha]) as RiceYield,
		RANK() OVER(PARTITION BY Year ORDER BY MAX([Rice yield-hg/ha]) desc) Rank
From [PortfolioProject 3]..['rice-yields']
Group By Year, Entity)

Select * From HighestRiceProduction
where Rank = 1
Order By RiceYield desc

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Looking at the Wheat Yield dataset
Select Entity, 
		MAX([Wheat yield-hg/ha]) as Wheat
From [PortfolioProject 3]..['wheat-yields']
Group By Entity
Order By Wheat desc
--Ireland

With HighestWheatProduction as
(Select Entity, 
		Year, 
		MAX([Wheat yield-hg/ha]) as WheatYield,
		RANK() OVER(PARTITION BY Year ORDER BY MAX([Wheat yield-hg/ha]) desc) Rank
From [PortfolioProject 3]..['wheat-yields']
Group By Year, Entity)

Select * From HighestWheatProduction
where Rank = 1
Order By WheatYield desc

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--It can be seen that the Rice Production in Key-crop-yield dataset and rice Yield dataset have some anomaly.
--According to the Key-crop-yield dataset, the highest producer of rice is Australia in the year 2014, when it produced 10.6827 hg/ha.
--But according to the data in rice yield dataset, the highest producer of rice is UAE in the year 2013, when it produced 36.7619 hg/ha

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Lets compare the rice production in key-crop-yield dataset and rice yield dataset
Select kcy.Entity, 
		MAX(kcy.[Rice_hg/ha]) as Rice_kcy,
		MAX(ry.[Rice yield-hg/ha]) as Rice_ry
From [PortfolioProject 3]..['key-crop-yields'] kcy
Join [PortfolioProject 3]..['rice-yields'] ry
	on kcy.Entity = ry.Entity
where kcy.Entity not in ('Asia', 'Africa', 'Asia, Central', 'Central America', 'Eastern Africa', 'Central African Republic', 'Eastern Asia',
'Eastern Europe', 'Europe', 'Europe, Western', 'Middle Africa', 'Land Locked Developing countries', 'Least Developed Countries', 'Low Income Food Deficit Countries',
'Net Food Importing Developing Countries', 'Northern Africa', 'Northern America', 'Northern Europe', 'Pacific Islands Trust Territory', 'European Union',
'Australia & New Zealand', 'South America', 'South eastern Asia', 'Southern Africa', 'Southern Asia', 'Southerrn Europe', 'Western Africa', 'Western Asia', 'World')
Group By kcy.Entity,
		 ry.Entity
Order By Rice_ry desc,
		 Rice_kcy desc

Select Distinct(Count(Entity))
From [PortfolioProject 3]..['key-crop-yields']
--13075

Select Distinct(COUNT(Entity))
From [PortfolioProject 3]..['rice-yields']
--11789

--The dataset contains different values for the same entity.
-- The key crop yield datset also does not contain a lot of values for certain entity that the rice yield datset do contain.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------