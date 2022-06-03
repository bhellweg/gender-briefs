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

#Load WB Cache of indicators and list of countries
new_wb_cache <- wb_cache()
wb_countries <- wb_countries()

#Load list of measures from Excel
measure_list <- readxl::read_xlsx('measure-list.xlsx')

#LOAD THE INDICATORS
wb_data <- wb_data(indicator = measure_list$Indicator, 
                   country = "All") 

#JOIN WITH COUNTRY LIST
wb_data1 <- right_join(wb_countries,wb_data, by = "iso3c") %>% 
  select(-c(2,3)) %>% 
  mutate(Country = country.y)

