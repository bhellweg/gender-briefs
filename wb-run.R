library(knitr)
library(wbstats)
library(tidyverse)

source('wb-load.R')
source('wb-functions.R')

#Create list of countries receiving briefs, 
#filtering out aggs and countries outside WB service

List <- wb_countries %>% 
  filter(!lending_type %in% c("Aggregates","Not classified")) %>% 
  select(country) %>% as_vector()

#For loop to create briefs
for(i in List){

#Set Country name
country_run <- i

source('wb-select.R')
source('tables.R')
source('factoid.R')
source('charts.R')

xfun::Rscript_call(
  rmarkdown::render,
  list(input = 'Gender-Briefs4.Rmd',
       output_file = paste('Briefs/',country_abbrev,
                           "-Gender-Briefs.pdf",
                           sep = ""),
       "pdf_document",encoding="UTF-8")
                    )
}

