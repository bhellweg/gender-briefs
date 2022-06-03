library(wbstats)
library(tidyverse)
library(formattable)
library(knitr)
library(sparkline)
library(htmltools)
library(ggplot2)
library(maps)
library(viridis)
library(ggstance)

## Main Table

#CREATE THE LONG VERSION OF THE TABLE
wbdata_long <- wb_data1 %>% 
  mutate(Country = country.y) %>% 
  select(ncol(.),1:(ncol(.)-1)) %>% 
  select(-c(2:7,9:13,15:19)) %>% 
  pivot_longer(5:ncol(.)) %>% 
  filter(date > 1989)

#CREATE THE TABLE WITH EACH DESIRED INDICATOR
{wb_table <- measures
  wb_table <- wb_table %>% 
    mutate(Measure = sapply(.$Indicator,FUN = wb_description)) %>% 
    mutate(Gender = sapply(.$Measure,FUN = wb_gender)) %>% 
    mutate(`Baseline` = sapply(.$Indicator,FUN = wb_baseline)) %>% 
    mutate(`Year` = sapply(.$Indicator,FUN = wb_baseyear)) %>% 
    mutate(`Rating` = sapply(.$Indicator,FUN = wb_performance)) %>% 
    mutate(`Year ` = sapply(.$Indicator,FUN = wb_perfyear)) %>% 
    mutate(`Region` = sapply(.$Indicator,FUN = wb_region)) %>% 
    mutate(`UMIC` = sapply(.$Indicator,FUN = wb_income)) %>% 
    mutate(`World` = sapply(.$Indicator,FUN = wb_world)) %>% 
    mutate(BaseChange = mapply(FUN = wb_change,x = Baseline,y = Rating)) %>% 
    mutate(RegionChange = mapply(FUN = wb_change,x = Region,y = Rating)) %>%    
    mutate(iconRegion = sapply(.$BaseChange,FUN = wb_icons)) %>% 
    select(c(1,6:17,2:5))
  wb_table$Measure <- gsub("Science, Technology, Engineering and Mathematics \\(STEM)","STEM",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("Women, Business and the Law: ","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("modeled estimate, ","modeled estimate ",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("exact ages ","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("\\(scale 1-100\\)","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("CVD","chronic vascular disease",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("CRD","cardiorespiratory disease",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", males \\(% of male adults\\)|, male \\(% of male population ages 15\\+\\)| \\(% of males ages 15 and above\\)"," \\(% age 15\\+\\)",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", females \\(% of female adults\\)|, female \\(% of female population ages 15\\+\\)| \\(% of females ages 15 and above\\)"," \\(% age 15\\+\\)",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", male \\(% of male youth population\\)"," \\(% of youth population\\)",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", female \\(% of female youth population\\)"," \\(% of youth population\\)",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", male \\(% of male employment\\)"," \\(% of employment\\)",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", female \\(% of female employment\\)"," \\(% of employment\\)",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", Male|, male|, adult male","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", Female|, female|, adult female","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(",female|,male"," ",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("  "," ",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("\\) \\(",", ",as.character(wb_table$Measure))
  save(wb_table, file = "wbtable.RData")}

## Gender Equality Data

{fulltable <- measure_list %>% 
  mutate(Measure = sapply(.$Indicator,FUN = wb_description)) %>% 
  mutate(Gender = sapply(.$Measure,FUN = wb_gender)) %>% 
  mutate(`Baseline` = 1) %>% 
  mutate(Baseyear = 1) %>% 
  mutate(`Rating` = sapply(.$Indicator,FUN = wb_performance)) %>% 
  mutate(Year = sapply(.$Indicator,FUN = wb_perfyear)) 
save(fulltable, file = "fulltable.RData")}
