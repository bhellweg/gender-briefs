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

## Main Table

#CREATE THE TABLE WITH EACH DESIRED INDICATOR
{fulltable <- measure_list %>% dplyr::select(-c(7:13))
  fulltable <- fulltable %>% 
    mutate(Measure = sapply(.$Indicator,FUN = wb_description)) %>% 
    mutate(Gender = sapply(.$Measure,FUN = wb_gender)) %>% 
    mutate(`Rating` = sapply(.$Indicator,FUN = wb_performance)) %>% 
    mutate(`Year ` = sapply(.$Indicator,FUN = wb_perfyear)) 
  fulltable$Measure <- gsub("Science, Technology, Engineering and Mathematics \\(STEM)","STEM",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("Women, Business and the Law: ","",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("programmes","programs",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("Years of School","Years of Schooling",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("modeled estimate, ","modeled estimate ",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("exact ages ","",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("\\(scale 1-100\\)","",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("CVD","chronic vascular disease",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("CRD","cardiorespiratory disease",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(", males \\(% of male adults\\)|, male \\(% of male population ages 15\\+\\)| \\(% of males ages 15 and above\\)"," \\(% age 15\\+\\)",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(", females \\(% of female adults\\)|, female \\(% of female population ages 15\\+\\)| \\(% of females ages 15 and above\\)"," \\(% age 15\\+\\)",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(", male \\(% of male youth population\\)"," \\(% of youth population\\)",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(", female \\(% of female youth population\\)"," \\(% of youth population\\)",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(", male \\(% of male employment\\)"," \\(% of employment\\)",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(", female \\(% of female employment\\)"," \\(% of employment\\)",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(", Male|, male|, adult male","",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(", Female|, female|, adult female","",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(",female|,male"," ",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("  "," ",as.character(fulltable$Measure))
  fulltable$Measure <- gsub("\\) \\(",", ",as.character(fulltable$Measure))
  fulltable$Measure <- gsub(" ages | age "," ",as.character(fulltable$Measure))
  #COMMENTED OUT BECAUSE THE LINKS CONTAIN AMPERSANDS. IF UPDATED ON THE PORTAL 
  #SIDE, REMOVE THE COMMENT AND TABLE LINKS WILL GO TO THE SPECIFIC COUNTRY. 
  #UPDATE THE FUNCTION WITH THE NEW LINK TYPE IN WB-FUNCTIONS
  #  fulltable$link <- mapply(FUN = link_completer,fulltable$link,fulltable$Rating)
  save(fulltable, file = "fulltable.RData")}

## Produce main table

{wb_table <- rbind(head(fulltable,71) %>% 
    filter(.$Indicator %in% head(measures$Indicator,nrow(measures)-5)),
    tail(fulltable,20) %>% 
      filter(.$Indicator %in% tail(measures$Indicator,5)))%>% 
    mutate(`Region` = sapply(.$Indicator,FUN = wb_region)) %>% 
    mutate(`UMIC` = sapply(.$Indicator,FUN = wb_income)) %>% 
    mutate(`World` = sapply(.$Indicator,FUN = wb_world)) %>% 
    mutate(`Baseline` = sapply(.$Indicator,FUN = wb_baseline)) %>% 
    mutate(`Year` = sapply(.$Indicator,FUN = wb_baseyear)) %>% 
    mutate(BaseChange = mapply(FUN = wb_change,x = Baseline,y = Rating)) %>% 
    mutate(RegionChange = mapply(FUN = wb_change,x = Region,y = Rating)) %>%    
    mutate(iconRegion = sapply(.$BaseChange,FUN = wb_icons)) %>% 
    dplyr::select(c(2,7:8,14:15,9:13,16:18,3:6))
  }

#Logic to switch out indicators as specified by WB team
if(region_abbrev %in% c('AFR','EAP','LAC','MNA')&&
   !country_run %in% FCV){
   if((wb_table[wb_table$Indicator=='SE.SEC.CMPT.LO.FE.ZS',6]>=90|is.na(wb_table[wb_table$Indicator=='SE.SEC.CMPT.LO.FE.ZS',6]))&&
   wb_table[wb_table$Indicator=='SE.SEC.CMPT.LO.MA.ZS',6]>=90|is.na(wb_table[wb_table$Indicator=='SE.SEC.CMPT.LO.MA.ZS',6])){
  wb_table[wb_table$Indicator=='SE.SEC.CMPT.LO.FE.ZS',]<-wb_table[wb_table$Indicator=='SE.TER.ENRR.FE',] %>% head(1)
  wb_table[wb_table$Indicator=='SE.SEC.CMPT.LO.MA.ZS',]<-wb_table[wb_table$Indicator=='SE.TER.ENRR.MA',] %>% head(1)
   }}

#Logic to switch out indicators as specified by WB team
if(region_abbrev %in% c('AFR','EAP','LAC','MNA','SAS')&&
   !country_run %in% FCV&&
   is.na(wb_table[wb_table$Indicator=='SP.UWT.TFRT',6])==T){
  wb_table[wb_table$Indicator=='SP.UWT.TFRT',]<-wb_table[wb_table$Indicator=='SP.DYN.CONM.ZS',]
}

#Logic to switch out indicators as specified by WB team
if(region_abbrev %in% c('AFR','EAP','ECA','LAC','MNA','SAS')&&
   is.na((wb_table[wb_table$Indicator=='SH.STA.ANV4.ZS',6]))==T){
  wb_table[wb_table$Indicator=='SH.STA.ANV4.ZS',]<-wb_table[wb_table$Indicator=='HF.STA.BRTC.ZS',]
}

#Logic to switch out indicators as specified by WB team
if(region_abbrev %in% c('AFR','EAP','ECA','LAC','MNA','SAS')&&
   is.na(as.character(wb_table[wb_table$Indicator=='SG.VAW.1549.ZS',6]))==T){
  wb_table[wb_table$Indicator=='SG.VAW.1549.ZS',]<-wb_table[wb_table$Indicator=='SG.VAW.AFSX.ZS',]
}

#Remove the replacement indicators from the final table.
wb_table <- wb_table %>% head(.,nrow(wb_table)-5) %>% as.data.frame()
save(wb_table, file = "wb_table.RData")
