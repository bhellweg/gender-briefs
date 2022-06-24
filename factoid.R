library(wbstats)
library(tidyverse)
library(formattable)
library(knitr)
library(htmltools)
library(ggplot2)
library(viridis)
library(ggstance)

factoids <- readxl::read_excel("factoid-logic.xlsx")

#This page creates five factoids for each briefing. It uses nesting if/else 
#logic to pick available measures based on WB prioritization and specs.

fact1 <- if(is.na(fulltable$Rating[72])==F){
  #HCI - A girl born today will be X percent as productive
  # as if she enjoyed complete education, health, and employment
  c(paste(factoids$Start[1],
          signif(digits=2,fulltable$Rating[72]*100),
          factoids$End[1],sep = " "),
    paste("(",fulltable$`Year `[72],")",sep = ""),
    paste(signif(digits=2,fulltable$Rating[72]*100),"percent"),
    fulltable$link[72])}else{
                                   
  if(is.na(fulltable$Rating[7])==F && fulltable$Rating[7] < 90){
    #Lower secondary school
    c(paste(factoids$Start[2],
            signif(digits=2,100-fulltable$Rating[7]),
            factoids$End[2],sep = " "),
      paste("(", fulltable$`Year `[7],")",sep = ""),
      paste(signif(digits=2,100-fulltable$Rating[7]),"percent"),
      fulltable$link[7])}else{
                                     
    if(is.na(fulltable$Rating[33])==F){
      #Youth not in education, employment, or training
      c(paste(signif(digits=2,fulltable$Rating[33]),
        factoids$End[3],sep = " "),
        paste("(",fulltable$`Year `[33],")",sep = ""),
        paste(wb_simple(fulltable$Rating[33])),
        fulltable$link[33])}else{
          
          if(is.na(fulltable$Rating[44]&&fulltable$Rating[44]-fulltable$Rating[43]>1)==F){
            #Financial Institution Account
            c(paste(signif(digits=2,fulltable$Rating[44]-fulltable$Rating[43]),
                    'percent more men than women in',country_run,
                    'have an account at a financial institution',sep = " "),
              paste("(",fulltable$`Year `[43],")",sep = ""),
              paste(signif(digits=2,(fulltable$Rating[44]-fulltable$Rating[43])),"percent"),
              fulltable$link[43])}
        }   }  }    

fact1

fact2 <- if(is.na(fulltable$Rating[74])==F&&fulltable$Rating[74]>100){
  #Maternal mortality in lifetime
  c(paste(signif(digits=2,fulltable$Rating[74]),
          factoids$End[5],sep = " "),
    paste("(",fulltable$`Year `[74],")",sep = ""),
    paste(signif(digits=2,fulltable$Rating[74])," in 1000"),
    fulltable$link[74])}else{
      
      if(is.na(fulltable$Rating[75])==F && fulltable$Rating[75] > 10){
        #Percent of women childbearing as a teenager
        c(paste(signif(digits=2,fulltable$Rating[75]),
                factoids$End[6],sep = " "),
          paste("(", fulltable$`Year `[75],")",sep = ""),
          paste(wb_simple(fulltable$Rating[75])),
          fulltable$link[75])}else{
            
            if(is.na(fulltable$Rating[53]&&fulltable$Rating[53]>5)==F){
              #Percent first married by age 18
              c(paste(signif(digits=2,fulltable$Rating[53]),
                      factoids$End[7],sep = " "),
                paste("(",fulltable$`Year `[53],")",sep = ""),
                paste(wb_simple(fulltable$Rating[53])),
                fulltable$link[53])}else{
                  
                  if(is.na(fulltable$Rating[28])==F&&fulltable$Rating[28]-fulltable$Rating[27]>2){
                    #Labor force participation gap
                    c(paste(factoids$Start[8],
                            signif(digits=2,fulltable$Rating[28]-fulltable$Rating[27]),
                            factoids$End[8],sep = " "),
                      paste("(",fulltable$`Year `[28],")",sep = ""),
                      paste(signif(digits=2,fulltable$Rating[28]-fulltable$Rating[27]), "points"),
                      fulltable$link[28])}else{
                        
                        if(is.na(fulltable$Rating[85])==F){
                          #Life expectancy at birth
                          c(paste('Women in',country_run,'live an average of',
                                  signif(digits=2,fulltable$Rating[85]),'years at birth',sep = " "),
                            paste("(",fulltable$`Year `[85],")",sep = ""),
                            paste(signif(digits=2,fulltable$Rating[85]), "years"),
                            fulltable$link[85])}else{
                              
                              if(is.na(fulltable$Rating[43])==F){
                                #Financial Institution Account
                                c(paste(signif(digits=2,fulltable$Rating[43]-fulltable$Rating[44]),
                                        'percent more men than women in',country_run,
                                        'have an account at a financial institution',sep = " "),
                                  paste("(",fulltable$`Year `[43],")",sep = ""),
                                  paste(signif(digits=2,fulltable$Rating[44]-fulltable$Rating[43]),"percent"),
                                  fulltable$link[43])}
                              }  }  }  }  }
fact2

fact3 <- if(is.na(fulltable$Rating[56])==F && fulltable$Rating[56]>1){
  #Female genital mutilation in lifetime
  c(paste(signif(digits=2,fulltable$Rating[56]),
          factoids$End[9],sep = " "),
    paste("(",fulltable$`Year `[56],")",sep = ""),
    paste(signif(digits=2,fulltable$Rating[56]), 'percent'),
    fulltable$link[56])}else{
      
      if(is.na(fulltable$Rating[76])==F && fulltable$Rating[76]>2.5){
        # Lifetime sexual violence incidence
        c(paste(signif(digits=2,fulltable$Rating[76]),
                factoids$End[10],sep = " "),
          paste("(",fulltable$`Year `[76],")",sep = ""),
          paste(signif(digits=2,fulltable$Rating[76]), 'percent'),
          fulltable$link[76])}else{
            
            if(is.na(fulltable$Rating[77])==F && fulltable$Rating[77]>2.5){
              #Intimate violence prevalence
              c(paste(signif(digits=2,fulltable$Rating[77]),
                      factoids$End[11],sep = " "),
                paste("(",fulltable$`Year `[77],")",sep = ""),
                paste(signif(digits=2,fulltable$Rating[77]), 'percent'),
                fulltable$link[77])}else{
                  
                  if(is.na(fulltable$Rating[55])==F && fulltable$Rating[55]>2.5){
                    #Physical or sexual violence prevalence
                    c(paste(signif(digits=2,fulltable$Rating[55]),
                            factoids$End[12],sep = " "),
                      paste("(",fulltable$`Year `[55],")",sep = ""),
                      paste(signif(digits=2,fulltable$Rating[55]), 'percent'),
                      fulltable$link[55])}else{
                        
                        if(is.na(fulltable$Rating[17])==F){
                          #Access to contraceptives
                          c(paste(signif(digits=2,fulltable$Rating[17]),
                                  factoids$End[23],sep = " "),
                            paste("(",fulltable$`Year `[17],")",sep = ""),
                            paste(signif(digits=2,(fulltable$Rating[17])),"percent"),
                            fulltable$link[17])}  }  }  }  }

fact3

fact4 <- if(is.na(fulltable$Rating[57])==F&&is.na(fulltable$Rating[57])>5){
  #Acceptability of wife beating
  c(paste(signif(digits=2,fulltable$Rating[57]),
          factoids$End[13],sep = " "),
    paste("(",fulltable$`Year `[57],")",sep = ""),
    paste(wb_simple(fulltable$Rating[57])),
    fulltable$link[57])}else{
      
      if(is.na(fulltable$Rating[78])==F && fulltable$Rating[78] != 100){
        #Ability to visit family, relatives, and friends
        c(paste(signif(digits=2,100-fulltable$Rating[78]),
                factoids$End[14],sep = " "),
          paste("(",fulltable$`Year `[78],")",sep = ""),
          paste(wb_simple(100-fulltable$Rating[78])),
          fulltable$link[78])}else{
            
            if(is.na(fulltable$Rating[79])==F){
              #Acceptability of wife beating when arguing
              c(paste(signif(digits=2,fulltable$Rating[79]),
                      factoids$End[15],sep = " "),
                paste("(", fulltable$`Year `[79],")",sep = ""),
                paste(wb_simple(fulltable$Rating[79])),
                fulltable$link[79])}else{
                  
                  if(is.na(fulltable$Rating[52])==F&&fulltable$Rating[52]>0){
                    #Proportion of seats in national parliament
                    c(paste(factoids$Start[16],
                            signif(digits=2,(100-fulltable$Rating[52])/fulltable$Rating[52]),
                            factoids$End[16],sep = " "),
                      paste("(",fulltable$`Year `[52],")",sep = ""),
                      paste(signif(digits=2,(100-fulltable$Rating[52])/fulltable$Rating[52]),"times"),
                      fulltable$link[52])}else{
                        
                        if(is.na(fulltable$Rating[3])==F){
                          #Literacy rate
                          c(paste(signif(digits=2,(100-fulltable$Rating[3])),
                                  'percent of women in',country_run,
                                  'are not able to read',sep = " "),
                            paste("(",fulltable$`Year `[3],")",sep = ""),
                            paste(signif(digits=2,(100-fulltable$Rating[3])),"percent"),
                            fulltable$link[3])}else{
                              
                              if(is.na(fulltable$Rating[43])==F){
                                #Account at financial institution
                                c(paste(signif(digits=2,fulltable$Rating[43]-fulltable$Rating[44]),
                                        'percent more men than women in',country_run,
                                        'have an account at a financial institution',sep = " "),
                                  paste("(",fulltable$`Year `[43],")",sep = ""),
                                  paste(signif(digits=2,fulltable$Rating[44]-fulltable$Rating[43]),"percent"),
                                  fulltable$link[43])}
                            }   }   }  }  }

fact4

fact5 <- if(is.na(fulltable$Rating[40])==F&&fulltable$Rating[40]>0){
  #Do not have any land, solely and jointly
  c(paste(ifelse(round(100 - fulltable$Rating[40],0)==100,
                 "Nearly",""),
    round(100 - fulltable$Rating[40],0),
          factoids$End[17],sep = " "),
    paste("(",fulltable$`Year `[40],")",sep = ""),
    ifelse(fulltable$Rating[40]==0,paste("Zero"),
           paste(round(100/fulltable$Rating[40],0)-1,"in",
          round(100/fulltable$Rating[40],0))),
    fulltable$link[40])}else{
      
      if(is.na(fulltable$Rating[60])==F && signif(digits=2,fulltable$Rating[60]/fulltable$Rating[59]) != 1){
        #Used the internet to pay bills or buy something online
        c(paste(factoids$Start[20],
                signif(digits=2,fulltable$Rating[60]/fulltable$Rating[59]),
                factoids$End[20],sep = " "),
          paste("(",fulltable$`Year `[60],")",sep = ""),
          paste( signif(digits=2,fulltable$Rating[60]/fulltable$Rating[59]), "times"),
          ifelse(is.na(fulltable$link[60]),fulltable$link[59],fulltable$link[60]))}else{
            
            if(is.na(fulltable$Rating[45])==F&&signif(digits=2,fulltable$Rating[45]/fulltable$Rating[46]) !=1){
              #Borrowing money to start, operate, or expand a business
              c(paste(factoids$Start[19],
                      signif(digits=2,fulltable$Rating[46]/fulltable$Rating[45]),
                      factoids$End[19],sep = " "),
                paste("(", fulltable$`Year `[45],")",sep = ""),
                paste(signif(digits=2,fulltable$Rating[46]/fulltable$Rating[45]),"times"),
                fulltable$link[45])}else{
                        
                        if(is.na(fulltable$Rating[49])==F){
                          #Women in a position of vulnerable employment
                          c(paste(wb_simple(signif(digits=2,fulltable$Rating[49])),
                                  factoids$End[4],sep = " "),
                            paste("(",fulltable$`Year `[49],")",sep = ""),
                            paste(wb_simple(fulltable$Rating[49])),
                            fulltable$link[49])}else{
                        
                        if(is.na(fulltable$Rating[12])==F){
                          #Fertility rate
                          c(paste("Women in",country_run,
                                  "will on average have",
                                  signif(digits=2,fulltable$Rating[12]),
                                  "children in their lifetimes",sep = " "),
                            paste("(",fulltable$`Year `[12],")",sep = ""),
                            paste(signif(digits=2,fulltable$Rating[12]),"children"),
                            fulltable$link[12])}else{
                              
                              if(is.na(fulltable$Rating[7])==F && fulltable$Rating[7] < 100){
                              #Lower secondary school
                              c(paste(factoids$Start[2],
                                      signif(digits=2,100-fulltable$Rating[7]),
                                      factoids$End[2],sep = " "),
                                paste("(",fulltable$`Year `[7],")",sep = ""),
                                paste(signif(digits=2,100-fulltable$Rating[7]),"percent"),
                                fulltable$link[7])}
                        
                   }   }  }  }  }

fact5

save(file = "rdata/fact1.RData",fact1)
save(file = "rdata/fact2.RData",fact2)
save(file = "rdata/fact3.RData",fact3)
save(file = "rdata/fact4.RData",fact4)
save(file = "rdata/fact5.RData",fact5)



