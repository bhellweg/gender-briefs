library(wbstats)
library(tidyverse)

#Load WB Cache of indicators and list of countries
new_wb_cache <- wb_cache()
wb_countries <- wb_countries()
wb_countries$country <- gsub("Gambia, The","The Gambia",as.character(wb_countries$country))
wb_countries$country <- gsub("Congo, Dem. Rep.","Dem. Republic of the Congo",as.character(wb_countries$country))
wb_countries$country <- gsub("Congo, Rep.","Republic of the Congo",as.character(wb_countries$country))
wb_countries$country <- gsub("Egypt, Arab Rep.","Arab Republic of Egypt",as.character(wb_countries$country))
wb_countries$country <- gsub("Micronesia, Fed. Sts.","Fed. States of Micronesia",as.character(wb_countries$country))
wb_countries$country <- gsub("Iran, Islamic Rep.","Islamic Republic of Iran",as.character(wb_countries$country))
wb_countries$country <- gsub("Korea, Rep.","Republic of Korea",as.character(wb_countries$country))
wb_countries$country <- gsub("Korea, Dem. People's Rep.","Dem. People's Rep. of Korea",as.character(wb_countries$country))
wb_countries$country <- gsub("Venezuela, RB","Bolivarian Republic of Venezuela",as.character(wb_countries$country))
wb_countries$country <- gsub("Yemen, Rep.","Republic of Yemen",as.character(wb_countries$country))

#Load list of measures from Excel
measure_list <- readxl::read_xlsx('measure-list.xlsx')

#LOAD THE INDICATORS
wb_data <- wb_data(indicator = unique(measure_list$Indicator), 
                   country = "All") 

#JOIN WITH COUNTRY LIST
wb_data1 <- right_join(wb_countries,wb_data, by = "iso3c") %>% 
  dplyr::select(-c(2,3)) %>% 
  mutate(Country = country.y)

#CREATE THE LONG VERSION OF THE TABLE
wbdata_long <- wb_data1 %>% 
  mutate(Country = country.y) %>% 
  dplyr::select(ncol(.),1:(ncol(.)-1)) %>% 
  dplyr::select(-c(3:7,9:13,15:19)) %>% 
  pivot_longer(6:ncol(.)) %>% 
  filter(date > 1989)
wbdata_long$Country <- gsub("Gambia, The","The Gambia",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Congo, Dem. Rep.","Dem. Republic of the Congo",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Congo, Rep.","Republic of the Congo",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Egypt, Arab Rep.","Arab Republic of Egypt",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Micronesia, Fed. Sts.","Fed. States of Micronesia",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Iran, Islamic Rep.","Islamic Republic of Iran",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Korea, Rep.","Republic of Korea",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Korea, Dem. People's Rep.","Dem. People's Rep. of Korea",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Venezuela, RB","Bolivarian Republic of Venezuela",as.character(wbdata_long$Country))
wbdata_long$Country <- gsub("Yemen, Rep.","Republic of Yemen",as.character(wbdata_long$Country))
