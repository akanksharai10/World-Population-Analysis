--Checking the database
select count(*) from world_population

--We have records of total 234 countries

select SUM(Y2022) from world_population
--World's total population as on year 2022 was 7,97,34,13,042 or almost 8 billion or almost 800 crores.

select round((cast(sum(Y2022) - sum(Y2020) as float) * 100)/CAST(sum(Y2020) as float),2) as Total_percentIncrease from world_population
--Wolrd Population has been increased by 1.71% in just 2 years.

select round((cast(sum(Y2022) - sum(Y2000) as float) * 100)/CAST(sum(Y2020) as float),2) as Total_percentIncrease from world_population
--Where as from Year 2000 Wolrd Population has been increased by 23.3%.

--Getting insights of all continet year by year
(select Continent,count(country) as Country_count,sum(Y2022)as population_count,2022 as Year from world_population group by Continent)
union
(select Continent,count(country) as Country_count,sum(Y2020)as population_count,2020 as Year from world_population group by Continent)
union
(select Continent,count(country) as Country_count,sum(Y2015)as population_count,2015 as Year from world_population group by Continent)
union
(select Continent,count(country) as Country_count,sum(Y2010)as population_count,2010 as Year from world_population group by Continent)
union
(select Continent,count(country) as Country_count,sum(Y2000)as population_count,2000 as Year from world_population group by Continent)
union
(select Continent,count(country) as Country_count,sum(Y1990)as population_count,1990 as Year from world_population group by Continent)
union
(select Continent,count(country) as Country_count,sum(Y1980)as population_count,1980 as Year from world_population group by Continent)
union
(select Continent,count(country) as Country_count,sum(Y1970)as population_count,1970 as Year from world_population group by Continent)
order by Year desc,population_count desc

--Let's see how much percentage populuation has increased during 2020 to 2022
select continent,country,y2022,y2020,(cast(Y2022-Y2020  as float) / cast(Y2022 as float)*100) as percent_diff from world_population
order by percent_diff desc

--As we can see most of African continent countrie's population has significantly increases

with Percentage_ranking as(
select top 30 continent,country,y2022,y2020,round((cast(Y2022-Y2020  as float) / cast(Y2022 as float)*100),2) as percent_diff from world_population
order by percent_diff desc)
select COUNT(*) as African_CountryCount from Percentage_ranking where Continent like '%Africa%'

--In 2020 to 2022, From top 30 countries in population increase, 26 countries were from Africa Continent

--Now since it is got intrested we should also check it out for duration 2022 to 2000 & 2022 to 1970 with population more than 5 lakhs
--We should also check for the least increase countries 

-----------------------------------------------2022 to 2000----------------------------------------------------------------
with Percentage_Topranking as(
select top 30 continent,country,y2022,y2000,round((cast(Y2022-Y2000  as float) / cast(Y2000 as float)*100),2) as percent_diff from world_population
where y2000 > 500000 order by percent_diff desc)
select *  from Percentage_Topranking
--select Continent,AVG(percent_diff)as Avg_increase_percent from Percentage_Topranking group by Continent order by Avg_increase_percent desc

--In Qatar(317%) & UAE(188%), Population increase percentage is signifcantly high than other countries or I think there were lot of people immigrated 
--to these countries between 2022 to 2020
--Many of Arab countires has doubled their population. 

with Percentage_Leastranking as(
select top 30 continent,country,y2022,y2000,round((cast(Y2022-Y2000  as float) / cast(Y2000 as float)*100),2) as percent_diff from world_population
order by percent_diff)
select *  from Percentage_Leastranking 
--select Continent,AVG(percent_diff) as Avg_increase_percent from Percentage_Leastranking group by Continent order by Avg_increase_percent

--Northan Mariana islands have dropped their populaton count by 38%

-----------------------------------------------2000 to 1970----------------------------------------------------------------
--Let's take population limit at 1 lakh population since Year is 1970
with Percentage_Topranking as(
select top 30 continent,country,y2000,y1970,round((cast(Y2000-Y1970  as float) / cast(Y1970 as float)*100),2) as percent_diff from world_population
where y1970 > 100000 order by percent_diff desc)
select *  from Percentage_Topranking 

--UAE has gain almost 1000% population increase followed by Qatae at almost 450%
--Again here also Many of Arab countires has more than doubled their population. 

with Percentage_Leastranking as(
select top 30 continent,country,y2000,y1970,round((cast(Y2000-Y1970  as float) / cast(Y1970 as float)*100),2) as percent_diff from world_population
order by percent_diff)
select *  from Percentage_Leastranking 

--Niue country has signifcant drop in population by 60% followed by Montserrat at almost 55%

-----------------------------------------------2022 to 1970----------------------------------------------------------------
with Percentage_Topranking as(
select top 30 continent,country,y2022,y1970,round((cast(Y2022-Y1970  as float) / cast(Y1970 as float)*100),2) as percent_diff from world_population
where y1970 > 100000 order by percent_diff desc)
select *  from Percentage_Topranking 

--In Qatar(317%) & UAE(188%), Population increase percentage is signifcantly high than other countries or I think there were lot of people immigrated 
--to these countries between 2022 to 2020
--Many of Arab countires has doubled their population. 

with Percentage_Leastranking as(
select top 30 continent,country,y2022,y1970,round((cast(Y2022-Y1970  as float) / cast(Y2000 as float)*100),2) as percent_diff from world_population
order by percent_diff)
select *  from Percentage_Leastranking 

--Country names are almost same as 2000 to 1970 but one thing to notice here that Northern Mariana Islands is not in the list so let's 
--check it out there records
select * from world_population where Country = 'Northern Mariana Islands'

--As per the record from year 2000 to 2010, Country has dropped the population by around 26000 due to some unknown reason.

--Now let's check it out overall percentage count that we already have in database

select Pop_percentage,* from world_population as w order by w.Pop_percentage desc

--In terms of population China has the highest 17.88% with population of 1425887337 followed by India with 17.77%
--There is not much major difference between China & India 
--Let check out in terms of percentage increase

select country,Y2022,Y2020,CAST(Y2022-Y2020 as float)/CAST(Y2020 as float)*100 as percent_increase
from world_population where Country in ('China','India')

--If we look at the increasing rate India is most likely to overtake China in terms of population in next few years

--Now that we have explored population data with respect to year & country, Let's move onto other columns

select continent,Country,Area,Density,Y2022 from world_population order by Area
--Russia country has the biggest Area followed by Canada & China where as Europe country Vatican City,Monaco has smallest area

with Total as (
select continent,Sum(Area) as Totalcovered_Area from world_population group by continent
)
--select sum(Totalcovered_Area) from Total ---Ans : 136059156
select continent,round((cast(Totalcovered_Area as float)/136059156)*100,2) as Covered_percent from Total order by Covered_percent desc

--Where as by continet Aisa covers the most area with 23.62% followed by Africa with 22.28%

--As density is define by Area / populatiuon, let's gather more insights

select country,area,Y2022, density from world_population where Y2022 > 100000 order by Density desc 
--Macau country's density is very much higher than any other country at whooping 23172 people per km A^2, followed by Singapore & Hong Kong

select country,area,Y2022, density from world_population order by Density

--2 Islands, Greenland & Falkland islands has very low denstiy under 1, followed by Desert country Western Sahara with around 2 people per km A^2
--Let's find out at continent level

select continent,avg(density) as Avg_density from world_population group by Continent order by Avg_density desc
--Asia continent is much denser than any other continent with Average density of 1025 people per km A^2 
--where as South America is least dense continent with average of only around 21 people per km A^2



