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

#Set region and income level
region_run <- wb_countries %>% 
  filter(country == country_run) %>% 
  select(9) %>% 
  head(.,1) %>% 
  as.character()
income_run <- wb_countries %>% 
  filter(country == country_run) %>% 
  select(15) %>% 
  head(.,1) %>% 
  as.character()
country_abbrev <- wb_countries %>% 
  filter(country == country_run) %>% 
  select(1) %>% 
  head(.,1) %>% 
  as.character()
country_iso2 <- wb_countries %>% 
  filter(country == country_run) %>% 
  select(2) %>% 
  head(.,1) %>% 
  as.character() %>% tolower()
country_iso2 <- wb_countries %>% 
  filter(country == country_run) %>% 
  select(2) %>% 
  head(.,1) %>% 
  as.character() %>% tolower()
region_abbrev <- wb_countries %>% 
  filter(country == country_run) %>% 
  select(10) %>% 
  head(.,1) %>% 
  as.character()
income_abbrev <- wb_countries %>% 
  filter(country == country_run) %>% 
  select(13) %>% 
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

save(region_abbrev,file = "region_abbrev.RData")
save(income_abbrev,file = "income_abbrev.RData")
save(country_abbrev,file = "country_abbrev.RData")
save(country_iso2,file = "country_iso2.RData")
save(region_run,file = 'region_run.RData')
save(income_run,file = 'income_run.RData')
save(country_run,file = 'country_run.RData')
save(count_region,file = 'count_region.RData')
save(count_income,file = 'count_income.RData')

incomerange <- ifelse(income_abbrev == "LIC",paste("\\\\$0 to \\\\$1,045"),
                ifelse(income_abbrev == "LMC",paste("\\\\$1,046 to \\\\$4,095"),
                 ifelse(income_abbrev == "UMC",paste("\\\\$4,096 to \\\\$12,695"),                             
                        paste("\\\\$12,696 and above"))))

save(incomerange,file = 'incomerange.RData')


#List of measures for AFR region
AFR <- measure_list %>% filter(number %in% c('m1','m2','m3','m4','m7','m8','m12','m13','m15','m16','m17','m18','m19',
             'm27','m28','m29','m30','m32','m33','m36','m37','m40','m41','m44','m45','m46','m47','m48',
             'm51','m52','m53','m55','m57',
             'm63','m64','m65','m66','m67','m68','m69','m70','m71'))%>% select(-1) %>% as.data.frame()
AFRbreaks <- c(13,14,28,29,33)

#List of measures for EAP region
EAP <- measure_list %>% filter(number %in% c('m1','m2','m7','m8','m11','m12','m13','m15','m16','m17','m18','m19',
             'm27','m28','m29','m30','m31','m32','m33','m36','m37','m38','m39','m40','m44','m45','m46','m47','m48',
             'm51','m52','m53','m55','m57',
             'm63','m64','m65','m66','m67','m68','m69','m70','m71'))%>% select(-1) %>% as.data.frame()
EAPbreaks <- c(12,13,29,30,34)

#List of measures for ECA region
ECA <- measure_list %>% filter(number %in% c('m1','m2','m9','m10','m11','m12','m13','m16','m18','m19',
             'm27','m28','m29','m30','m31','m32','m33','m34','m35','m36','m37','m38','m39','m40','m43','m44','m45','m46','m47','m48',
             'm51','m52','m53','m55',
             'm63','m64','m65','m66','m67','m68','m69','m70','m71'))%>% select(-1) %>% as.data.frame()
ECAbreaks <- c(10,11,30,31,34)

#List of measures for LAC region
LAC <- measure_list %>% filter(number %in% c('m1','m2','m7','m8','m11','m12','m13','m15','m16','m17','m18','m19,
             m27','m28','m29','m30','m32','m33','m36','m37','m38','m39','m40','m31','m48','m44','m45','m46','m47,
             m53','m51','m52','m54','m55',
             'm63','m64','m65','m66','m67','m68','m69','m70','m71'))%>% select(-1) %>% as.data.frame()
LACbreaks <- c(11,12,26,27,30)

#List of measures for MENA region
MENA <- measure_list %>% filter(number %in% c('m1','m2','m7','m8','m11','m12','m13','m15','m16','m17','m18','m19',
              'm27','m28','m29','m30','m32','m33','m34','m35','m36','m37','m40','m43','m44','m45','m46','m47','m48',
              'm51','m52','m53','m54','m55',
              'm63','m64','m65','m66','m67','m68','m69','m70','m71'))%>% select(-1) %>% as.data.frame()
MENAbreaks <- c(12,13,29,30,34)

#List of measures for SAR region
SAR <- measure_list %>% filter(number %in% c('m1','m2','m3','m4','m12','m13','m15','m16','m17','m18','m19',
             'm27','m28','m29','m30','m31','m32','m33','m36','m37','m40','m41','m42','m44','m45','m46','m47','m48',
             'm51','m52','m53','m55','m57','m58',
             'm63','m64','m65','m66','m67','m68','m69','m70','m71'))%>% select(-1) %>% as.data.frame()
SARbreaks <- c(11,12,28,29,34)

#List of measures for FCV countries
FCV <- measure_list %>% filter(number %in% c('m1','m2','m3','m4','m5','m6','m12','m13','m16','m18','m19','m20','m21',
             'm27','m28','m29','m30','m32','m33','m36','m37','m40','m44','m45','m46','m47','m48',
             'm51','m52','m53','m55',
             'm63','m64','m65','m66','m67','m68','m69','m70','m71'))%>% select(-1) %>% as.data.frame()
FCVbreaks <- c(13,14,27,28,32)

#Define measures based on region_run value
measures <- if(region_run=="Sub-Saharan Africa"){AFR}else{
  if(region_run=="East Asia & Pacific"){EAP}else{
    if(region_run=="Europe & Central Asia"){ECA}else{
      if(region_run=="Latin America & Caribbean"){LAC}else{
        if(region_run=="Middle East & North Africa"){MENA}else{
          if(region_run=="South Asia"){SAR}else{FCV}}}}}}

#Define breaks by region_run value
breaks <- if(region_run=="Sub-Saharan Africa"){AFRbreaks}else{
  if(region_run=="East Asia & Pacific"){EAPbreaks}else{
    if(region_run=="Europe & Central Asia"){ECAbreaks}else{
      if(region_run=="Latin America & Caribbean"){LACbreaks}else{
        if(region_run=="Middle East & North Africa"){MENAbreaks}else{
          if(region_run=="South Asia"){SARbreaks}else{FCVbreaks}}}}}}
save(breaks, file = "breaks.RData")

#Insert a sentence in the doc if the country is FCV
FCVsentence <- if(measures %in% FCV){ c(country_run," is a Fragile, Conflict, or Violence (FCV) impacted country. ")}else{""}
save(FCVsentence,file = "FCVsentence.RData")




