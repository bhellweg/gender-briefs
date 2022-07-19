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

#Create empty sets for FCV measures so FCV countries use their regional indicators
#rather than the FCV-specific indicators.
FCV <- c()
FCVhi<- c()
FCVmed<- c()
FCVfrag<- c()

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

#NOTE: IF YOU ARE INTERESTED IN USING SEPARATE MEASURES FOR FCV COUNTRIES, RUN
#THE CODE BELOW. OTHERWISE, EVERYTHING ABOVE IS SUFFICIENT FOR PRODUCING THE 
#GENDER BRIEFINGS.

FCVlist <- read.csv("FCV-countries.csv", fileEncoding = 'UTF-8-BOM')
FCVlist$country <- gsub("Gambia, The","The Gambia",as.character(FCVlist$country))
FCVlist$country <- gsub("Congo, Dem. Rep.","Dem. Republic of the Congo",as.character(FCVlist$country))
FCVlist$country <- gsub("Congo, Rep.","Republic of the Congo",as.character(FCVlist$country))
FCVlist$country <- gsub("Egypt, Arab Rep.","Arab Republic of Egypt",as.character(FCVlist$country))
FCVlist$country <- gsub("Micronesia, Fed. Sts.","Fed. States of Micronesia",as.character(FCVlist$country))
FCVlist$country <- gsub("Iran, Islamic Rep.","Islamic Republic of Iran",as.character(FCVlist$country))
FCVlist$country <- gsub("Korea, Rep.","Republic of Korea",as.character(FCVlist$country))
FCVlist$country <- gsub("Korea, Dem. People's Rep.","Dem. People's Rep. of Korea",as.character(FCVlist$country))
FCVlist$country <- gsub("Venezuela, RB","Bolivarian Republic of Venezuela",as.character(FCVlist$country))
FCVlist$country <- gsub("Yemen, Rep.","Republic of Yemen",as.character(FCVlist$country))

FCV <- FCVlist %>% select(2) %>% unlist()
FCVhi <- FCVlist %>% filter(.$status == "High") %>% select(2) %>% unlist()
FCVmed <- FCVlist %>% filter(.$status == "Medium") %>% select(2) %>% unlist()
FCVfrag <- FCVlist %>% filter(.$status == "Fragile") %>% select(2) %>% unlist()

#For loop to create FCV briefs
for(i in FCV){
  
  #Set Country name
  country_run <- i
  
  source('wb-select.R')
  source('tables.R')
  source('factoid.R')
  source('charts.R')
  
  xfun::Rscript_call(
    rmarkdown::render,
    list(input = 'Gender-Briefs4.Rmd',
         #Note that this section is saved to a different folder.
         output_file = paste('FCV-Briefs/',country_abbrev,
                             "-Gender-Briefs.pdf",
                             sep = ""),
         "pdf_document",encoding="UTF-8")
  )
}
