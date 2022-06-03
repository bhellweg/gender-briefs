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

# Functions

#Create a function that adds the description of the indicator
wb_description <- function(code){
  wb_search(code, cache = new_wb_cache)[2]%>% 
    head(.,1) %>% 
    as.character()
}

#Create a function that removes gender from indicators so they can be combined
wb_gender <- function(text){
  ifelse(grepl(c(", female|, Female|, adult female|,female"),text),"Female",
         ifelse(grepl(c(", male|, Male|, adult male|,male"),text),"Male",""))
}

#Create a function that sets one year as a baseline and shows its value
wb_baseline <- function(code){
  wbdata_long %>% 
    filter(Country == country_run) %>%
    filter(name == code) %>% 
    na.omit() %>% 
    filter(date %in% c(1990:2010)) %>% 
    top_n(.,1,date) %>% 
    select(6) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function that shows the base year value.
wb_baseyear <- function(code){
  wbdata_long %>% 
    filter(Country == country_run) %>%
    filter(name == code) %>% 
    na.omit() %>% 
    filter(date %in% c(1990:2010)) %>% 
    top_n(.,1,date) %>% 
    select(4) %>% 
    as.numeric() %>% 
    signif(.,digits = 4)
}

#Create a function that shows latest-year performance
wb_performance <- function(code){
  wbdata_long %>% 
    filter(Country == country_run) %>%
    filter(name == code) %>% 
    na.omit() %>% 
    filter(date > 2010) %>% 
    top_n(.,1,date) %>% 
    select(6) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function that shows the latest measured year
wb_perfyear <- function(code){
  wbdata_long %>% 
    filter(Country == country_run) %>%
    filter(name == code) %>% 
    na.omit() %>% 
    filter(date > 2010) %>%
    top_n(.,1,date) %>% 
    select(4) %>% 
    as.numeric() %>% 
    signif(.,digits = 4)
}

#Create a function showing the region latest value
wb_region <- function(code){
  
  wbdata_long %>% 
    filter(name == code) %>%
    filter(Country == region_run) %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(6) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function showing the income latest value
wb_income <- function(code){
  
  wbdata_long %>% 
    filter(name == code) %>%
    filter(Country == income_run) %>% 
    select(-c(2,3)) %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(4) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function showing the world latest value
wb_world <- function(code){
  
  wbdata_long %>% 
    filter(name == code) %>%
    filter(Country == "World") %>% 
    select(-c(2,3)) %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(4) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function showing if the value went up or down by over 10%
wb_change <- function(x,y){
  ifelse(y>(1.1*x),1,
         ifelse(x>(1.1*y),-1,
                ifelse(anyNA(c(x,y)),"",0)))
}


#Create a function adding the icons for progress
wb_icons <- function(x){
  ifelse(anyNA(x),"naicon.png",
         ifelse(x == -1,"downicon.png",
                ifelse(x == 1, "upicon.png","righticon.png")))
}