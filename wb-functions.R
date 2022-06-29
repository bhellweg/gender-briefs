library(wbstats)
library(tidyverse)
library(MASS)

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
  with(wbdata_long,wbdata_long[name==code&
                                 iso3c==country_abbrev&
                                 date %in% c(1990:2010)&
                                 is.na(value)==F,7]) %>%
    na.omit() %>%
    tail(.,1) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function that shows the base year value.
wb_baseyear <- function(code){
  with(wbdata_long,wbdata_long[name==code&
                                 iso3c==country_abbrev&
                                 date %in% c(1990:2010)&
                                 is.na(value)==F,5]) %>%
    na.omit() %>%
    tail(.,1) %>% 
    as.numeric() %>% 
    signif(.,digits = 4)
}

#Create a function that shows latest-year performance
wb_performance <- function(code){
  with(wbdata_long,wbdata_long[name==code&
                                 iso3c==country_abbrev&
                                 date > 2010&
                                 is.na(value)==F,7]) %>%
    na.omit() %>%
    tail(.,1) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function that shows the latest measured year
wb_perfyear <- function(code){
  with(wbdata_long,wbdata_long[name==code&
                                 iso3c==country_abbrev&
                                 date > 2010&
                                 is.na(value)==F,5]) %>%
    na.omit() %>%
    tail(.,1) %>% 
    as.numeric() %>% 
    signif(.,digits = 4)
}

#Create a function showing the region latest value
wb_region <- function(code){
  
  with(wbdata_long,wbdata_long[name==code&
                                 Country == region_run&
                                 date > 2010&
                                 is.na(value)==F,7]) %>%
    na.omit() %>%
    tail(.,1) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function showing the income latest value
wb_income <- function(code){
  
  with(wbdata_long,wbdata_long[name==code&
                                 Country == income_run&
                                 date > 2010&
                                 is.na(value)==F,7]) %>%
    na.omit() %>%
    tail(.,1) %>% 
    as.numeric() %>% 
    signif(.,digits = 3)
}

#Create a function showing the world latest value
wb_world <- function(code){
  
  with(wbdata_long,wbdata_long[name==code&
                                 Country == "World"&
                                 date > 2010&
                                 is.na(value)==F,7]) %>%
    na.omit() %>%
    tail(.,1) %>% 
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
  ifelse(anyNA(x),"icon/naicon.png",
         ifelse(x == -1,"icon/downicon.png",
                ifelse(x == 1, "icon/upicon.png","icon/righticon.png")))
}

#Simplifying numbers for the factoids
wb_simple <- function(num){
  x<-round(num,0)
      if(x==0){return("Nearly Zero")}else{
        if(x<100){return(paste0(MASS:::.rat(x/100,max.denominator = 100)$rat[1],
                                " in ",
                                MASS:::.rat(x/100,max.denominator = 100)$rat[2]))}else{
          if(x==100){return("One hundred percent")}else{
             x
                      }
                      }
                      }
                      }

#Rename regions
make_abbrev <- function(x){
  if(x == "LCN"){x <- "LAC"}
  if(x == "SAS"){x <- "SAS"}
  if(x == "SSF"){x <- "SSA"}
  if(x == "ECS"){x <- "ECA"}
  if(x == "MEA"){x <- "MNA"}
  if(x == "EAS"){x <- "EAP"}
  if(x == "NAC"){x <- "NAC"}
  paste(x)
}

#Complete links. Update when the links change.
link_completer <- function(link,indicator){
  paste0(link,
         ifelse(!is.na(indicator),
                paste0("/?geos=WLD_",
                country_abbrev,
                "&view=trend"),
                '/?view=trend'
                ))
}

