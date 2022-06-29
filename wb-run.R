#Sets working directory to where file is stored.
setwd(
dirname(rstudioapi::getActiveDocumentContext()$path)
)

#Loads and installs relevant packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(knitr, wbstats, tidyverse, ggplot2, MASS)

#Loads relevant data (you only need to do this if the data is not already loaded)
source('wb-load.R')

#Creates functions for next steps
source('wb-functions.R')

#Create list of countries receiving briefs, 
#filtering out aggs and countries outside WB service

List <- wb_countries %>% 
  filter(!lending_type %in% c("Aggregates","Not classified")) %>% 
  dplyr::select(country) %>% as_vector() 

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
  list(input = 'Gender-Briefs.Rmd',
       output_file = paste('Briefs/',country_abbrev,
                           "-Gender-Briefs.pdf",
                           sep = ""),
       "pdf_document",encoding="UTF-8")
                    )
}
