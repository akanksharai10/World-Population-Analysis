create table world_population(
"Code" varchar(50),"Country" varchar(50),
"Capital" varchar(50), "Continent" varchar(50),
"2022" bigint,"2020" bigint,"2015" bigint,
"2010" bigint,"2000" bigint,"1990" bigint,
"1980" bigint,"1970" bigint,"Area" bigint,
"Density" decimal(18,10),"GrowthRate" decimal(18,10),
"Pop_percentage" decimal(18,10)
)

select * from world_population