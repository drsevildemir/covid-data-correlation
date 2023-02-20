--Correlation Analyses-----------------------


select corr(extreme_poverty,life_expectancy)
    from "covid-data";
---output=-0.75





--Is there a correlation between diabetes prevalence and deaths per population in countries?
select  corr(diabetes_prevalence,MaxDeathRate)
from (select location, diabetes_prevalence,max(total_deaths/"covid-data".population) as MaxDeathRate
    from "covid-data"
where continent is not null
group by location, diabetes_prevalence
order by location) as  DD;
---Output=0.003 (NO)






--Is there a correlation between new death and people fully vaccinated in time?
select corr(newdeathperpopulation,fullyvaccinatedperpopulation)
from (select location,date,new_deaths/"covid-data".population as newdeathperpopulation,people_fully_vaccinated/"covid-data".population as fullyvaccinatedperpopulation
    from "covid-data"
    where people_fully_vaccinated is not null and location='World'
order by location,date) as NDFVP;
--Output = -0.74 (Negative correlation)





---Total deaths and fully vaccinated people amount correlation
select corr(Totaldeathrate,Maxfullyvaccinated)
from (select location,
             max(total_deaths/"covid-data".population) as Totaldeathrate,
             max(people_fully_vaccinated/"covid-data".population) as Maxfullyvaccinated
       from "covid-data"
       where continent is not null
group by location
order by location) as LDFV;
--Output=0.22




----correlation between total deaths and extreme poverty
select corr(Totaldeathrate,extreme_poverty)
from (select location, max(total_deaths/"covid-data".population) as Totaldeathrate,extreme_poverty
    from "covid-data"
    where "covid-data".extreme_poverty is not null and continent is not null
    group by location, extreme_poverty
order by location) as TDEP;
--output=0.50







----Total deaths and Cardiovascular rate correlation
select corr(Totaldeathrate,cardiovasc_death_rate)
from (select location, max(total_deaths/"covid-data".population) as Totaldeathrate,cardiovasc_death_rate
    from "covid-data"
    where "covid-data".cardiovasc_death_rate is not null
    group by location, cardiovasc_death_rate
order by location) as DCVR
---output=0.18




--Total death and People over 65 amount correlation
select  corr(Totaldeathrate,aged_65_older)
from (select location, max(total_deaths/"covid-data".population) as Totaldeathrate,aged_65_older
    from "covid-data"
    where "covid-data".aged_65_older is not null
    group by location, aged_65_older
order by location) as DA65
--Output=0.66



---total deaths smoker correlation
select corr(Totaldeathrate,Smoker)
from (select  location,max(total_deaths/"covid-data".population) as Totaldeathrate,female_smokers+"covid-data".male_smokers as Smoker
    from "covid-data"
    where female_smokers is not null and location !='World'
group by location, female_smokers+"covid-data".male_smokers
    order by location) as DS;
----output=0.46




---Two risk factor for Covid deaths(old age and smoking)  and Total deaths correlation
select corr(Totaldeathrate,Rate)
from (select location,
       max(total_deaths/"covid-data".population) as Totaldeathrate,aged_65_older,
       female_smokers+"covid-data".male_smokers as Smoker,
       aged_65_older *(female_smokers+"covid-data".male_smokers) as Rate
    from "covid-data"
    where (aged_65_older is not null ) and
          ("covid-data".male_smokers is not null )
      and ("covid-data".female_smokers is not null) and
          (continent is not null )
group by location, aged_65_older, female_smokers+"covid-data".male_smokers
order by location) as TDA65S;
---output=0.73 (Total deaths and over 65 =0.66,Total deaths and smoker rate=0.46)

