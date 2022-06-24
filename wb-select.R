library(wbstats)
library(tidyverse)
library(formattable)
library(knitr)
library(htmltools)
library(ggplot2)
library(viridis)
library(ggstance)

#Set region and income level, create abbreviations and names
region_run <- wb_countries %>% 
  filter(country == country_run) %>% 
  dplyr::select(9) %>% 
  head(.,1) %>% 
  as.character()
income_run <- wb_countries %>% 
  filter(country == country_run) %>% 
  dplyr::select(15) %>% 
  head(.,1) %>% 
  as.character()
country_abbrev <- wb_countries %>% 
  filter(country == country_run) %>% 
  dplyr::select(1) %>% 
  head(.,1) %>% 
  as.character()
country_iso2 <- wb_countries %>% 
  filter(country == country_run) %>% 
  dplyr::select(2) %>% 
  head(.,1) %>% 
  as.character() %>% tolower()
region_abbrev <- wb_countries %>% 
  filter(country == country_run) %>% 
  dplyr::select(7) %>% 
  head(.,1) %>% 
  make_abbrev()
income_abbrev <- wb_countries %>% 
  filter(country == country_run) %>% 
  dplyr::select(13) %>% 
  head(.,1) %>% 
  as.character()
count_region <- wb_countries %>% 
  filter(region == region_run) %>% 
  nrow() %>% 
  as.character()
count_income <- wb_countries %>% 
  filter(income_level == income_run) %>% 
  nrow() %>% 
as.character()

save(region_abbrev,file = "rdata/region_abbrev.RData")
save(income_abbrev,file = "rdata/income_abbrev.RData")
save(country_abbrev,file = "rdata/country_abbrev.RData")
save(country_iso2,file = "rdata/country_iso2.RData")
save(region_run,file = 'rdata/region_run.RData')
save(income_run,file = 'rdata/income_run.RData')
save(country_run,file = 'rdata/country_run.RData')
save(count_region,file = 'rdata/count_region.RData')
save(count_income,file = 'rdata/count_income.RData')

#UPDATE EVERY YEAR AS THE INCOME THRESHOLDS CHANGE
incomerange <- ifelse(income_abbrev == "LIC",paste("\\\\$0 to \\\\$1,045"),
                ifelse(income_abbrev == "LMC",paste("\\\\$1,046 to \\\\$4,095"),
                 ifelse(income_abbrev == "UMC",paste("\\\\$4,096 to \\\\$12,695"),                             
                        paste("\\\\$12,696 and above"))))

save(incomerange,file = 'rdata/incomerange.RData')


#List of breaks for AFR region

AFRbreaks <- c(13,14,29,30,34)
EAPbreaks <- c(12,13,29,30,34)
ECAbreaks <- c(10,11,30,31,34)
LACbreaks <- c(12,13,29,30,34)
MENAbreaks<- c(12,13,29,30,34)
SARbreaks <- c(11,12,28,29,34)
FCVbreaks <- c(13,14,27,28,31)

#IF YOU WANT TO USE THE FCV FORMAT, SWAP THE COMMENTS SO FCV AND THE FCV SUBSETS
#ARE ACTIVE. UPDATE THEM EVERY YEAR BASED ON FCV STATUS. IF YOU WANT FCV COUNTRIES
#TO USE REGIONAL MEASURES, MAKE THE EMPTY SUBSETS ACTIVE
# FCV <- c(
#   'Afghanistan',
#   'Somalia',
#   'Syrian Arab Republic',
#   'Republic of Yemen',
#   'Armenia',
#   'Azerbaijan',
#   'Burkina Faso',
#   'Burundi',
#   'Cameroon',
#   'Central African Republic',
#   'Chad',
#   'Dem. Republic of the Congo',
#   'Ethiopia',
#   'Haiti',
#   'Iraq',
#   'Libya',
#   'Mali',
#   'Mozambique',
#   'Myanmar',
#   'Niger',
#   'Nigeria',
#   'South Sudan',
#   'Republic of the Congo',
#   'Eritrea',
#   'Guinea-Bissau',
#   'Kosovo',
#   'Lebanon',
#   'Papua New Guinea',
#   'Sudan',
#   'Bolivarian Republic of Venezuela',
#   'Zimbabwe',
#   'Comoros',
#   'Kiribati',
#   'Marshall Islands',
#   'Fed. States of Micronesia',
#   'Solomon Islands',
#   'Timor-Leste',
#   'Tuvalu'
# )
# 
# 
# FCVhi <- c('Afghanistan',
#            'Somalia',
#            'Syrian Arab Republic',
#            'Republic of Yemen',
#            'Armenia',
#            'Azerbaijan'
# )
# FCVmed <- c(
#   'Burkina Faso',
#   'Burundi',
#   'Cameroon',
#   'Central African Republic',
#   'Chad',
#   'Dem. Republic of the Congo',
#   'Ethiopia',
#   'Haiti',
#   'Iraq',
#   'Libya',
#   'Mali',
#   'Mozambique',
#   'Myanmar',
#   'Niger',
#   'Nigeria',
#   'South Sudan'
# )
# 
# FCVfrag <- c(
#   'Republic of the Congo',
#   'Eritrea',
#   'Guinea-Bissau',
#   'Kosovo',
#   'Lebanon',
#   'Papua New Guinea',
#   'Sudan',
#   'Bolivarian Republic of Venezuela',
#   'Zimbabwe',
#   'Comoros',
#   'Kiribati',
#   'Marshall Islands',
#   'Fed. States of Micronesia',
#   'Solomon Islands',
#   'Timor-Leste',
#   'Tuvalu'
# )

FCV <- c()
FCVhi<- c()
FCVmed<- c()
FCVfrag<- c()

#Define measures based on region_run value
measures <- 
    if(country_run %in% FCV){measure_list %>% filter(FCV==1)}else{
  if(region_run=="Sub-Saharan Africa"){measure_list %>% filter(AFR==1)}else{
  if(region_run=="East Asia & Pacific"){measure_list %>% filter(EAP==1)}else{
    if(region_run=="Europe & Central Asia"){measure_list %>% filter(ECA==1)}else{
      if(region_run=="Latin America & Caribbean"){measure_list %>% filter(LAC==1)}else{
        if(region_run=="Middle East & North Africa"){measure_list %>% filter(MENA==1)}else{
          if(region_run=="South Asia"){measure_list %>% filter(SAR==1)}}}}}}
 }
measures <- measures %>% dplyr::select(-c(7:13))

#Define breaks by region_run value
breaks <- 
    if(country_run %in% FCV){FCVbreaks}else{
  if(region_run=="Sub-Saharan Africa"){AFRbreaks}else{
  if(region_run=="East Asia & Pacific"){EAPbreaks}else{
    if(region_run=="Europe & Central Asia"){ECAbreaks}else{
      if(region_run=="Latin America & Caribbean"){LACbreaks}else{
        if(region_run=="Middle East & North Africa"){MENAbreaks}else{
          if(region_run=="South Asia"){SARbreaks}}}}}}
 }
save(breaks, file = "rdata/breaks.RData")

#Insert a sentence in the doc if the country is FCV
FCVsentence <- if(country_run %in% FCVhi){ paste0(country_run," is a Fragile, Conflict, or Violence (FCV) impacted country in high-intensity conflict. ")}else{
  if(country_run %in% FCVmed){ paste0(country_run," is a Fragile, Conflict, or Violence (FCV) impacted country in medium-intensity conflict. ")}else{
    if(country_run %in% FCVfrag){paste0(country_run," is a Fragile, Conflict, or Violence (FCV) impacted country with high instituional and social fragility. ")}else{""}
  }}

save(FCVsentence,file = "rdata/FCVsentence.RData")




