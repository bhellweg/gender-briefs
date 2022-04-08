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

new_wb_cache <- wb_cache()

vlinks <- c(
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/hd-hci-lays/",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/hd-hci-lays/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-adt/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-adt/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-prm-cmpt-zs",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-prm-cmpt-zs",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-sec-cmpt-lo-zs",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-sec-cmpt-lo-zs",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/hd-hci-hlos",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/hd-hci-hlos",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-ter-enrr/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-ter-enrr/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-ter-grad-fe-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sp-dyn-tfrt-in/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sh-sta-mmrt/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sh-hiv-1524-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sh-hiv-1524-zs/",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sh-prv-smok",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sh-prv-smok",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sl-tlf-acti-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sl-tlf-acti-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sl-emp-vuln-zs/",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sl-emp-vuln-zs/",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sl-uem-neet-zs/",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sl-uem-neet-zs/",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-ter-grad-fe-zs",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/se-ter-grad-fe-zs",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-tim-uwrk/",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-tim-uwrk/",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/ic-wef-llco-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/ic-wef-llco-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/fin1-t-a/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/fin1-t-a/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-own-ld/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-own-ld/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sp-2024-fe-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sp-ado-tfrt/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-gen-parl-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/ic-frm-femm-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-vaw-1549-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/fin14abca-t-d/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/fin14abca-t-d/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-dmk/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-dmk/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sp-dyn-zs/",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx",
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx-as",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx-en",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx-mo",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx-mr",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx-pe",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx-pr",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx-py",	
  "http://graphicacy-wb-gender-portal.s3-website-us-east-1.amazonaws.com/indicators/sg-law-indx-wp")

m0<- c("Indicator","direction","type","simple")
m1 <- c(  "HD.HCI.LAYS.FE",'up', 'number', 'average years of school for women')
m2 <- c(  "HD.HCI.LAYS.MA",'up', 'number', 'average years of school for men')
m3 <- c(  "SE.ADT.LITR.FE.ZS",'up', 'percent', 'women are able to read')
m4 <- c(  "SE.ADT.LITR.MA.ZS",'up', 'percent', 'men are able to read')
m5 <- c(  "SE.PRM.CMPT.FE.ZS",'up', 'percent', 'women complete primary school')
m6 <- c(  "SE.PRM.CMPT.MA.ZS",'up', 'percent', 'men complete primary school')
m7 <- c(  "SE.SEC.CMPT.LO.FE.ZS",'up', 'percent', 'women complete lower secondary school')
m8 <- c(  "SE.SEC.CMPT.LO.MA.ZS",'up', 'percent', 'men complete lower secondary school')
m9 <- c(  "HD.HCI.HLOS.FE",'up', 'number', 'average harmonized test score for women')
m10 <- c(  "HD.HCI.HLOS.MA",'up', 'number', 'average harmonized test score for men')
m11 <- c(  "SE.TER.ENRR.FE",'up', 'percent', 'women enroll in tertiary school')
m12 <- c(  "SE.TER.ENRR.MA",'up', 'percent', 'men enroll in tertiary school')
m13 <- c(  "SE.TER.GRAD.FE.SI.ZS",'up', 'percent', 'STEM graduates are women')
m14 <- c(  "SP.DYN.TFRT.IN",'down', 'number', 'fertility rate for women')
m15 <- c(  "SH.STA.MMRT",'down', 'number', 'maternal mortality per 100,000 births')
m16 <- c(  "SH.HIV.1524.FE.ZS",'down', 'percent', 'women are diagnosed with HIV')
m17 <- c(  "SH.HIV.1524.MA.ZS",'down', 'percent', 'men are diagnosed with HIV')
m18 <- c(  "SH.PRV.SMOK.FE",'down', 'percent', 'women use tobacco')
m19 <- c(  "SH.PRV.SMOK.MA",'down', 'percent', 'men use tobacco')
m20 <- c(  "SL.TLF.CACT.FE.ZS",'up', 'percent', 'women participate in the labor force')
m21 <- c(  "SL.TLF.CACT.MA.ZS",'up', 'percent', 'men participate in the labor force')
m22 <- c(  "SL.EMP.VULN.FE.ZS",'down', 'percent', 'women have vulnerable employment')
m23 <- c(  "SL.EMP.VULN.MA.ZS",'down', 'percent', 'men have vulnerable employment')
m24 <- c(  "SL.UEM.NEET.FE.ZS",'down', 'percent', 'young women are not in education, employment, or training')
m25 <- c(  "SL.UEM.NEET.MA.ZS",'down', 'percent', 'young men are not in education, employment, or training')
m26 <- c(  "SL.AGR.EMPL.FE.ZS",'down', 'percent', 'women are employed in agriculture')
m27 <- c(  "SL.AGR.EMPL.MA.ZS",'down', 'percent', 'men are employed in agriculture')
m28 <- c(  "SG.TIM.UWRK.FE",'down', 'percent', 'hours per day women spend in unpaid domestic and care work')
m29 <- c(  "SG.TIM.UWRK.MA",'down', 'percent', 'hours per day men spend in unpaid domestic and care work')
m30 <- c(  "IC.WEF.LLCO.FE.ZS",'up', 'percent', 'women are business owners')
m31 <- c(  "IC.WEF.LLCO.MA.ZS",'down', 'percent', 'men are business owners')
m32 <- c(  "FX.OWN.TOTL.FE.ZS",'up', 'percent', 'women hold an account at a financial institution')
m33 <- c(  "FX.OWN.TOTL.MA.ZS",'up', 'percent', 'men hold an account at a financial institution')
m34 <- c(  "SG.OWN.LDAJ.FE.ZS",'up', 'percent', 'women own land alone and jointly')
m35 <- c(  "SG.OWN.LDAL.MA.ZS",'up', 'percent', 'men own land alone')
m36 <- c(  "SP.M18.2024.FE.ZS",'down', 'percent', 'women were first married by age 18')
m37 <- c(  "SP.ADO.TFRT",'down', 'number', 'young women gave birth as adolescents per 1000 women')
m38 <- c(  "SG.GEN.PARL.ZS",'up', 'percent', 'seats in national parliament are held by women')
m39 <- c(  "IC.FRM.FEMM.ZS",'up', 'percent', 'firms have a female top manager')
m40 <- c(  "SG.VAW.1549.ZS",'down', 'percent', 'women are subjected to physical and/or sexual violence in the last year')
m41 <- c(  "fin14abca.t.d.2",'up', 'percent', 'women used the internet to buy something on line in the last year')
m42 <- c(  "fin14abca.t.d.1",'up', 'percent', 'men used the internet to buy something on line in the last year')
m43 <- c(  "SG.DMK.FOOD.FN.ZS",'up', 'percent', 'women participate in the decision of what food to cook daily')
m44 <- c(  "SG.DMK.ALLD.FN.ZS",'up', 'percent', 'women particiapte in major household and personal decisions')
m45 <- c(  "SP.DYN.CONU.ZS",'up', 'percent', 'women report using contraceptive methods')
m46 <- c(  "SG.LAW.INDX",   'up', 'number', '')
m47 <- c(  "SG.LAW.INDX.AS",'up', 'number', '')
m48 <- c(  "SG.LAW.INDX.EN",'up', 'number', '')
m49 <- c(  "SG.LAW.INDX.MO",'up', 'number', '')
m50 <- c(  "SG.LAW.INDX.MR",'up', 'number', '')
m51 <- c(  "SG.LAW.INDX.PE",'up', 'number', '')
m52 <- c(  "SG.LAW.INDX.PR",'up', 'number', '')
m53 <- c(  "SG.LAW.INDX.PY",'up', 'number', '')
m54 <- c(  "SG.LAW.INDX.WP",'up', 'number', '')

measures <- rbind(m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,
      m11,m12,m13,m14,m15,m16,m17,m18,m19,m20,
      m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,
      m31,m32,m33,m34,m35,m36,m37,m38,m39,m40,
      m41,m42,m43,m44,m45,m46,m47,m48,m49,m50,
      m51,m52,m53,m54) %>% as.data.frame()
rownames(measures)<-NULL
colnames(measures)<-m0


country_run <- "Colombia"

wb_data <- wb_data(indicator = measures$Indicator, 
                   country = "all") 

wb_countries <- wb_countries()

wb_data1 <- right_join(wb_countries,wb_data, by = "iso3c") %>% 
  select(-c(2,3))

# Functions

options(digits=3)

wb_description <- function(code){
  wb_search(code, cache = new_wb_cache)[2]%>% 
    head(.,1) %>% 
    as.character()
}

wb_gender <- function(text){
  ifelse(grepl(c(", female|, Female|, adult female"),text),"Female",
         ifelse(grepl(c(", male|, Male|, adult male"),text),"Male",""))
}

wb_measures <- function(data){
  data %>% filter(!.$Indicator %in% c("SE.ADT.LITR.FE.ZS",
                                      "SE.ADT.LITR.MA.ZS",
                                      "SE.PRM.CMPT.FE.ZS",	
                                      "SE.PRM.CMPT.MA.ZS",
                                      "SE.SEC.CMPT.LO.FE.ZS",
                                      "SE.SEC.CMPT.LO.MA.ZS",
                                      "SH.HIV.1524.FE.ZS",
                                      "SH.HIV.1524.MA.ZS",
                                      "SG.OWN.LDAJ.FE.ZS",
                                      "SG.OWN.LDAL.MA.ZS",
                                      "SG.DMK.FOOD.FN.ZS",
                                      "SG.DMK.ALLD.FN.ZS",
                                      "SP.DYN.CONU.ZS"))
}

wb_baseline <- function(code){
  wbdata_long %>% 
    filter(Country == country_run) %>%
    filter(name == code) %>% 
    na.omit() %>% 
    filter(date %in% c(1990:2010)) %>% 
    top_n(.,1,date) %>% 
    select(6) %>% 
    as.numeric() %>% 
    round(.,digits = 1)
}

wb_baseyear <- function(code){
  wbdata_long %>% 
    filter(Country == country_run) %>%
    filter(name == code) %>% 
    na.omit() %>% 
    filter(date %in% c(1990:2010)) %>% 
    top_n(.,1,date) %>% 
    select(4) %>% 
    as.numeric() %>% 
    round(.,digits = 1)
}

wb_performance <- function(code){
  wbdata_long %>% 
    filter(Country == country_run) %>%
    filter(name == code) %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(6) %>% 
    as.numeric() %>% 
    round(.,digits = 1)
}

wb_perfyear <- function(code){
  wbdata_long %>% 
    filter(Country == country_run) %>%
    filter(name == code) %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(4) %>% 
    as.numeric() %>% 
    round(.,digits = 1)
}

wb_region <- function(code){
  
  region_code <- wbdata_long %>% 
    filter(Country == country_run) %>% 
    slice(1) %>% 
    select(region) %>% 
    as.character()
  
  wbdata_long %>% 
    filter(name == code) %>%
    filter(Country == region_code) %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(6) %>% 
    as.numeric() %>% 
    round(.,digits = 1)
}

wb_income <- function(code){
  
  income_code <- wbdata_long %>% 
    filter(Country == country_run) %>% 
    slice(1) %>% 
    select(income_level) %>% 
    as.character()
  
  wbdata_long %>% 
    filter(name == code) %>%
    filter(Country == income_code) %>% 
    select(-c(2,3)) %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(4) %>% 
    as.numeric() %>% 
    round(.,digits = 1)
}

wb_world <- function(code){
  
  wbdata_long %>% 
    filter(name == code) %>%
    filter(Country == "World") %>% 
    select(-c(2,3)) %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(4) %>% 
    as.numeric() %>% 
    round(.,digits = 1)
}

wbsparkline <- function(code){
  wbdata_long %>% 
    filter(name == code) %>% 
    filter(Country == country_run) %>% 
    filter(date > 1989) %>% 
    select(-c(1:5))
}

wb_change <- function(x,y){
  ifelse(y>(1.1*x),1,
         ifelse(x>(1.1*y),-1,
         ifelse(anyNA(c(x,y)),"",0)))
}

wb_goodbad <- function(x,y,scale){
 if(scale == "down") {
    ifelse(y>(1.1*x),1,
        ifelse(x>(1.1*y),-1,
            ifelse(anyNA(c(x,y)),"",0)))
   }else{
    ifelse(y>(1.1*x),-1,
        ifelse(x>(1.1*y),1,
            ifelse(anyNA(c(x,y)),"",0)))
                }
}

wb_icons <- function(x){
  ifelse(anyNA(x),"naicon.png",
    ifelse(x == -1,"downicon.png",
         ifelse(x == 1, "upicon.png","righticon.png")))
}

wb_simple <- function(x){
  if(x=='5%'){return("One in twenty")}else{
    if(x=='10%'){return("One in ten")}else{
      if(x=='15%'){return("One in six")}else{
        if(x=='20%'){return("One in five")}else{
          if(x=='25%'){return("One in four")}else{
            if(x=='30%'){return("One in three")}else{
              if(x=='35%'){return("One in three")}else{
                if(x=='40%'){return("Two in five")}else{
                  if(x=='45%'){return("Under one in two")}else{
                    if(x=='50%'){return("One in two")}else{
                      if(x=='55%'){return("Over one in two")}else{
                        if(x=='60%'){return("Three in five")}else{
                          if(x=='65%'){return("Two out of three")}else{
                            if(x=='70%'){return("Almost three in four")}else{
                              if(x=='75%'){return("Three in four")}else{
                                if(x=='80%'){return("Four out of five")}else{
                                  if(x=='85%'){return("Five out of every six")}else{
                                    if(x=='90%'){return("Nine out of ten")}else{
                                      if(x=='95%'){return("Almost every")}else{
                                        if(x=='100%'){return("One hundred percent")}else{
                                          x
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } 
    }  
  }}

## Main Table


wbdata_long <- wb_data1 %>% 
  mutate(Country = country.y) %>% 
  select(-c(1:6,8:12,14:18)) %>% 
  select(c(58,1:57)) %>% 
  pivot_longer(5:58) 

{wb_table <- measures
  wb_table <- wb_table %>% 
    mutate(Measure = sapply(.$Indicator,FUN = wb_description)) %>% 
    mutate(Gender = sapply(.$Measure,FUN = wb_gender)) %>% 
    mutate(`Baseline` = sapply(.$Indicator,FUN = wb_baseline)) %>% 
    mutate(`Year` = sapply(.$Indicator,FUN = wb_baseyear)) %>% 
    mutate(`Rating` = sapply(.$Indicator,FUN = wb_performance)) %>% 
    mutate(`Year ` = sapply(.$Indicator,FUN = wb_perfyear)) %>% 
    mutate(`Region` = sapply(.$Indicator,FUN = wb_region)) %>% 
    mutate(`Income` = sapply(.$Indicator,FUN = wb_income)) %>% 
    mutate(`Global` = sapply(.$Indicator,FUN = wb_world)) %>% 
    mutate(Trendvalues = sapply(.$Indicator,FUN = wbsparkline)) %>% 
    mutate(BaseChange = mapply(FUN = wb_change,x = Baseline,y = Rating)) %>% 
    mutate(RegionChange = mapply(FUN = wb_goodbad,x = Region,y = Rating,scale = direction)) %>%    
    mutate(vlinks = vlinks) %>% 
    mutate(iconRegion = sapply(.$BaseChange,FUN = wb_icons)) %>% 
    wb_measures() %>% 
    select(c(1,5:18,2:4))
  wb_table$Measure <- gsub("\\(modeled ILO estimate)","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("\\(national estimate)","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("Science, Technology, Engineering and Mathematics \\(STEM)","STEM",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("Women, Business and the Law: ","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("modeled estimate, ","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub("\\(scale 1-100)","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", Male|, male \\(% gross\\)|, males \\(% of male adults\\)|, male \\(% of male population ages 15\\+\\) |, male \\(% of male employment\\) |, male \\(% of male youth population\\)|, male \\(% of 24 hour day\\)|, male \\(% of population ages 15\\+\\)|, male \\(% age 15\\+\\)","",as.character(wb_table$Measure))
  wb_table$Measure <- gsub(", Female|, female \\(% gross\\)|, females \\(% of female adults\\)|, female \\(% of female population ages 15\\+\\) |, female \\(% of female employment\\) |, female \\(% of female youth population\\)|, female \\(% of 24 hour day\\)|, female \\(% of population ages 15\\+\\)|, female \\(% age 15\\+\\)","",as.character(wb_table$Measure))
  save(wb_table, file = "wbtable.RData")}

#introtext
firstlow <- function(x) {
  substr(x, 1, 1) <- tolower(substr(x, 1, 1))
  x
}

{introtext <- wb_table %>% 
  filter(Gender != "Male") %>% 
  select(-c(1,3,5,7:18)) %>% 
  mutate(BestWorst = mapply(FUN = function(x,y){(y-x)/x},x = Baseline,y = Rating)) %>% 
  head(.,nrow(.)-8) %>% 
  na.omit() %>% 
  arrange(., by_group = desc(BestWorst)) 
  introtext$Measure<-firstlow(introtext$Measure)
  introtext$Measure <- gsub(" \\(.*","",as.character(introtext$Measure))
save(introtext, file = "introtext.RData")}

## Gender Equality Data

{callouts <- wb_table %>% 
  slice(.,c(7,1,12,24,29)) %>% 
  select(-c(1,3:5,7:16)) %>% 
  mutate(Rating = mapply(x = Rating,y = type,FUN = function(x,y){if(y=="percent"){
    scales::percent(x/100,accuracy = 5)}else
    {return(signif(x,2))}})) 
callouts <- callouts %>% 
  mutate(Ratio = sapply(.$Rating,FUN = wb_simple))
save(callouts, file = "callouts.RData")}

  
## Map

map_performance <- function(country.fn){
  wbdata_long %>% 
    filter(Country == country.fn) %>%
    filter(name == "SG.LAW.INDX") %>% 
    na.omit() %>% 
    top_n(.,1,date) %>% 
    select(6) %>% 
    as.numeric() %>% 
    round(.,digits = 1)
}

# Pick Countries
neighbors <- c(
  'Argentina',
  'Bolivia',
  'Brazil',
  'Chile',
  'Colombia',
  'Ecuador',
  'Guyana',
  'Paraguay',
  'Peru',
  'Suriname',
  'Uruguay',
  'Venezuela'
)
# Retrieve the map data
mapdata <- map_data("world", region = neighbors) 

# Compute the centroid as the mean longitude and latitude
# Used as label coordinate for country's names
region.lab.data <- mapdata %>%
  group_by(region) %>%
  summarise(long = mean(long), lat = mean(lat)) %>% 
  mutate(Value = sapply(.$region,FUN = map_performance))

map_region <- mapdata %>% 
  left_join(.,region.lab.data %>% 
              select(-c(2,3)),by = "region") %>% 
ggplot(., aes(x = long, y = lat)) +
  geom_polygon(aes( group = group, fill = Value))+
#  geom_text(aes(label = region), data = region.lab.data,  size = 3, hjust = 0.5)+
  theme_void()+
  labs(title = "Women and the Law Regional Scores")+
  theme(text=element_text(size=8),plot.margin=unit(c(0,.1,0,0.1), "null"))+
  theme(aspect.ratio=1)

save(map_region, file = "mapregion.RData")

#law plot

{lawdata <- wbdata_long %>% 
    filter(Country == country_run) %>% 
    filter(name %in% c("SG.LAW.INDX.AS",	
                       "SG.LAW.INDX.EN",	
                       "SG.LAW.INDX.MO",	
                       "SG.LAW.INDX.MR",	
                       "SG.LAW.INDX.PE",	
                       "SG.LAW.INDX.PR",	
                       "SG.LAW.INDX.PY",	
                       "SG.LAW.INDX.WP")) %>% 
    filter(date > 2000)   %>% 
    mutate(Measure = sapply(.$name,FUN = wb_description)) %>%
    select(-c(1:3,5)) 
  lawdata$Measure <- gsub("Women, Business and the Law: ","",as.character(lawdata$Measure))
  lawdata$Measure <- gsub("Indicator Score \\(scale 1-100)","",as.character(lawdata$Measure))}

lawchart <- lawdata %>% 
  ggplot(aes(x = date, y = value, color = Measure, group = Measure))+
  geom_line(size = 1.5,position = ggstance::position_dodgev(height = 3)) +
  scale_color_brewer(palette = 'Dark2') +
  theme_classic() +
  labs(x = "Year Measured", y = "Indicator Value", title = "Women & The Law Indicators")+
  theme(text=element_text(size=8),legend.title = element_blank(),
        legend.key.height = unit(.5,'cm'))+
  theme(aspect.ratio=.6,plot.margin=unit(c(0,.1,0,0.1), "null"))+
  coord_fixed()
save(lawchart, file = "lawchart.RData")


#Bottom Links

globalr <- c(
  'The Equality Equation: Advancing the Participation of Women and Girls in STEM',
  'Economic impacts of child marriage: global synthesis report',
  '',
  'Childcare and Mothers’ Labor Market Outcomes in Lower- and Middle-Income Countries',
  'Breaking Barriers: Female Entrepreneurs Who Cross Over to Male-Dominated Sectors',
  'Measuring Women and Men’s Work: Main Findings from a Joint ILO and World Bank Study in Sri Lanka',
  '',
  'What Works to Prevent Violence against Women',
  '',
  'Gender Dimensions of Disaster Risk and Resilience: Existing Evidence',
  'The Gender Dimensions of Forced Displacement: A Synthesis of New Research'
)
regionalr <- c(
  'Facilitating school-to-work transitions',
  'Attracting more women into STEM felds',
  'Reducing boys’ school dropout and helping boys at risk',
  'Expanding access to affordable and quality care',
  'Improving women’s access to quality employment',
  'Improving the performance of women-owned firms',
  'Increasing women’s ownership and control of productive assets',
  'Preventing and addressing violence against women and girls',
  'Reducing teen pregnancy',
  '',
  ''
)

globallinks <- c(
  'https://openknowledge.worldbank.org/handle/10986/34317',
  'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/530891498511398503/economic-impacts-of-child-marriage-global-synthesis-report',
  '',
  'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/450971635788989068/childcare-and-mothers-labor-market-outcomes-in-lower-and-middle-income-countries',
  'https://openknowledge.worldbank.org/handle/10986/36940',
  'https://openknowledge.worldbank.org/handle/10986/36257',
  '',
  'https://www.whatworks.co.za/documents/publications/374-evidence-reviewfweb/file',
  '',
  'https://openknowledge.worldbank.org/handle/10986/35202',
  'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/895601643214591612/the-gender-dimensions-of-forced-displacement-a-synthesis-of-new-research'
)

regionallinks <- c(
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Facilitating%20the%20School%20to%20Work%20Transition%20of%20Young%20Women.pdf',
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Atracting%20more%20Young%20Women%20into%20STEM%20Fields.pdf',
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Reducing%20Boys\'%20School%20Droppout%20and%20Helping%20Boys%20at%20Risk.pdf',
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Expanding%20Access%20to%20Affordable%20and%20Quality%20Care.pdf',
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Improving%20Women\'s%20Access%20to%20Quality%20Employment.pdf',
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Improving%20the%20Performance%20of%20Women-Owned%20Firms.pdf',
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Improving%20the%20Performance%20of%20Women-Owned%20Firms.pdf',
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Preventing%20and%20Addressing%20Violence%20Against%20Women%20and%20Girls.pdf',
  'https://worldbankgroup.sharepoint.com/sites/LCR/Documents/Gender/Country%20Scorecards/Reducing%20Teen%20Pregnancy.pdf',
  '',
  ''
)

resources <- data.frame(globalr,regionalr)

resources <- resources %>% 
  mutate(`Global Resources` = globalr) %>% 
  mutate(`Regional Resources` = regionalr) %>% 
  select(-c(1:2))
save(region, file = "resources.RData")
save(regionallinks, file = "regionallinks.RData")
save(globallinks, file = "globallinks.RData")





