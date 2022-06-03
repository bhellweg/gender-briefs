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

factoids <- readxl::read_excel("Gender Brief Factoid Logic.xlsx")

fact1 <- if(is.na(fulltable$Rating[72])==F){
  #HCI - A girl born today will be X percent as productive
  # as if she enjoyed complete education, health, and employment
  c(paste(factoids$Start[1],
          round(fulltable$Rating[72]*100,0),
          factoids$End[1],paste("(",
          fulltable$Year[72],")",sep = ""),sep = " "),
    paste( round(fulltable$Rating[72]*100,0),"percent"),
    fulltable$link[72])}else{
                                   
  if(is.na(fulltable$Rating[5])==F && fulltable$Rating[5] != 100){
    #Lower secondary school
    c(paste(factoids$Start[2],
            100-fulltable$Rating[5],
            factoids$End[2],paste("(",
            fulltable$Year[5],")",sep = ""),sep = " "),
      paste(fulltable$Rating[5],"percent"),
      fulltable$link[5])}else{
                                     
    if(is.na(fulltable$Rating[36])==F){
      #Youth not in education, employment, or training
      c(paste(fulltable$Rating[36],
              factoids$End[3],paste("(",
              fulltable$Year[36],")",sep = ""),sep = " "),
        paste("1 in",round(100/fulltable$Rating[36],0)),
        fulltable$link[36])}else{
                                       
      if(is.na(fulltable$Rating[49])==F){
        #Women in a position of vulnerable employment
        c(paste(factoids$Start[4],
                fulltable$Rating[49],
                factoids$End[4],paste("(",
                fulltable$Year[49],")",sep = ""),sep = " "),
          paste("1 in ",round(100/fulltable$Rating[49],0)),
        fulltable$link[49])}
          
        }  }  }    

fact1

fact2 <- if(is.na(fulltable$Rating[74])==F&&fulltable$Rating[74]>100){
  #Maternal mortality in lifetime
  c(paste(round(fulltable$Rating[74],1),
          factoids$End[5],paste("(",
          fulltable$Year[74],")",sep = ""),sep = " "),
    paste(round(fulltable$Rating[74],1)," in 1000"),
    fulltable$link[74])}else{
      
      if(is.na(fulltable$Rating[75])==F && fulltable$Rating[75] >10 ){
        #Percent of women childbearing as a teenager
        c(paste(fulltable$Rating[75],
                factoids$End[6],paste("(",
                fulltable$Year[75],")",sep = ""),sep = " "),
          paste("1 in",round(100/fulltable$Rating[75],0)),
          fulltable$link[75])}else{
            
            if(is.na(fulltable$Rating[53])==F){
              #Percent first married by age 18
              c(paste(fulltable$Rating[53],
                      factoids$End[7],paste("(",
                      fulltable$Year[53],")",sep = ""),sep = " "),
                paste("1 in",round(100/fulltable$Rating[53],0)),
                fulltable$link[53])}
                  
                }  }  
fact2

fact3 <- if(is.na(fulltable$Rating[56])==F && fulltable$Rating[56]>1){
  #Female genital mutilation in lifetime
  c(paste(fulltable$Rating[56],
          factoids$End[8],paste("(",
          fulltable$Year[56],")",sep = ""),sep = " "),
    paste(fulltable$Rating[56], 'percent'),
    fulltable$link[56])}else{
      
      if(is.na(fulltable$Rating[76])==F){
        # Lifetime sexual violence incidence
        c(paste(fulltable$Rating[76],
                factoids$End[9],paste("(",
                fulltable$Year[76],")",sep = ""),sep = " "),
          paste("1 in",round(100/fulltable$Rating[76],0)),
          fulltable$link[76])}else{
            
            if(is.na(fulltable$Rating[77])==F){
              #Intimate violence prevalence
              c(paste(fulltable$Rating[77],
                      factoids$End[10],paste("(",
                      fulltable$Year[77],")",sep = ""),sep = " "),
                paste("1 in",round(100/fulltable$Rating[77],0)),
                fulltable$link[77])}else{
                  
                  if(is.na(fulltable$Rating[55])==F){
                    #Physical or sexual violence prevalence
                    c(paste(fulltable$Rating[55],
                            factoids$End[11],paste("(",
                            fulltable$Year[55],")",sep = ""),sep = " "),
                      paste("1 in ",round(100/fulltable$Rating[55],0)),
                      fulltable$link[55])}else{
                        
                        if(is.na(fulltable$Rating[24])==F){
                          #Access to contraceptives
                          c(paste(round(100-fulltable$Rating[24],0),
                                  factoids$End[21],paste("(",
                                                         fulltable$Year[24],")",sep = ""),sep = " "),
                            paste("1 in",round(100/(100-fulltable$Rating[24]),0)),
                            fulltable$link[24])}}
                  
                }  }  }    

fact3

fact4 <- if(is.na(fulltable$Rating[57])==F){
  #Acceptability of wife beating
  c(paste(round(fulltable$Rating[57],0),
          factoids$End[12],paste("(",
          fulltable$Year[57],")",sep = ""),sep = " "),
    paste("1 in",round(100/fulltable$Rating[57],)),
    fulltable$link[57])}else{
      
      if(is.na(fulltable$Rating[78])==F && fulltable$Rating[78] != 100){
        #Ability to visit family, relatives, and friends
        c(paste(fulltable$Rating[78],
                factoids$End[13],paste("(",
                fulltable$Year[78],")",sep = ""),sep = " "),
          paste("1 in",fulltable$Rating[78]),
          fulltable$link[78])}else{
            
            if(is.na(fulltable$Rating[79])==F){
              #Acceptability of wife beating when arguing
              c(paste(fulltable$Rating[79],
                      factoids$End[14],paste("(",
                      fulltable$Year[79],")",sep = ""),sep = " "),
                paste("1 in",round(100/fulltable$Rating[79],0)),
                fulltable$link[79])}
            }  }    

fact4

fact5 <- if(is.na(fulltable$Rating[41])==F){
  #Do not have any land, solely and jointly
  c(paste(100 - fulltable$Rating[41],
          factoids$End[15],paste("(",
          fulltable$Year[41],")",sep = ""),sep = " "),
    paste(round(100/fulltable$Rating[41],0)-1,"in",
          round(100/fulltable$Rating[41],0)),
    fulltable$link[41])}else{
      
      if(is.na(fulltable$Rating[60])==F && round(fulltable$Rating[60]/fulltable$Rating[59],1) != 1){
        #Borrowing money to start, operate, or expand a business
        c(paste(factoids$Start[18],
                round(fulltable$Rating[60]/fulltable$Rating[59],1),
                factoids$End[18],paste("(",
                                       fulltable$Year[47],")",sep = ""),sep = " "),
          paste( round(fulltable$Rating[60]/fulltable$Rating[59],1), "times"),
          fulltable$link[47])}else{
            
            if(is.na(fulltable$Rating[47])==F&&round(fulltable$Rating[47]/fulltable$Rating[46],1) !=1){
              c(paste(factoids$Start[17],
                      round(fulltable$Rating[47]/fulltable$Rating[46],1),
                      factoids$End[17],paste("(",
                      fulltable$Year[46],")",sep = ""),sep = " "),
                paste(round(fulltable$Rating[47]/fulltable$Rating[46],1),"times"),
                fulltable$link[46])}else{
                  
                  if(is.na(fulltable$Rating[82])==F){
                    c(paste(factoids$Start[19],
                            round(100/fulltable$Rating[82],0),
                            factoids$End[19],paste("(",
                            fulltable$Year[81],")",sep = ""),sep = " "),
                      paste(round(fulltable$Rating[82],0),"percent"),
                      fulltable$link[82])}
                  
                }  }  }    

fact5

save(file = "fact1.RData",fact1)
save(file = "fact2.RData",fact2)
save(file = "fact3.RData",fact3)
save(file = "fact4.RData",fact4)
save(file = "fact5.RData",fact5)



