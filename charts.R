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

#Employment Charts

#Set colors and size for charts
female <- "#303c84"
male <- "#707cbc"
textsize <- 30
datasize <- 10

#CREATE HCI, EMPLOYMENT, WBL, MARRIAGE CHARTS

#EMPLOYMENT
#Create employment dataset
{employment <- wbdata_long %>% 
    filter(name %in% c("SL.TLF.CACT.FE.ZS",'SL.TLF.CACT.MA.ZS')) %>% 
    filter(Country == country_run) %>% 
    mutate(value = value/100) %>% 
    select(-c(2,3)) %>% 
    na.omit() 
  #Rename Employment indicators to female/male
  employment[employment=="SL.TLF.CACT.FE.ZS"] <- "Female"
  employment[employment=="SL.TLF.CACT.MA.ZS"] <- "Male" 
  colnames(employment) <- c("Country","Year","Gender","Value")
  emp_headtail <- employment %>% 
    filter(Year %in% c(max(employment$Year),min(employment$Year)))}

#Create employment chart
emp_country <- 
  employment %>% 
  ggplot(.,aes(x=Year,y = Value,fill= Gender))+
    geom_area(aes(y = Value), alpha = 0.8,position = "identity")+
  geom_line(size = 1,color = female)+
  #    geom_point(data = emp_headtail,aes(shape=Gender), size = 8)+
  ylim(0,100)+
  theme_void()+
  theme(legend.position = "bottom",
        text = element_text(size = textsize),
        plot.margin = margin(5,5,10,0),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        plot.title = element_text(margin=margin(0,0,15,0)),
        axis.text = element_text())+
  scale_fill_manual(values=c(female,male))+
  ggtitle("Labor Force Participation (%, 15+)")+
  scale_y_continuous(labels = scales::percent_format(accuracy = 5L))
  
#Save chart
ggsave("emp_country.png",emp_country,height = 4500/2.5,width=6000/2.5,units = "px")

#Create HCI country dataset

HCIdata <- wbdata_long %>% 
  filter(name %in% c("HD.HCI.OVRL.FE",'HD.HCI.OVRL.MA')) %>% 
  pivot_wider(.,names_from = name, values_from = value) %>% 
  na.omit() %>% 
  group_by(Country) %>% 
  top_n(.,1,date) %>% 
  select(c(1,4,5,6,2,3))

#HCI
#Create HCI aggregates data
{HCIaggs <- rbind(HCIdata %>% 
                    ungroup() %>% 
                    filter(region == region_run) %>% 
                    group_by(region) %>% 
                    summarise(across(everything(),mean)) %>% 
                    select(2:5,1,6),
                  HCIdata %>% 
                    ungroup() %>% 
                    filter(income_level == income_run) %>% 
                    group_by(income_level) %>% 
                    summarise(across(everything(),mean)) %>% 
                    select(2:6,1),
                  HCIdata %>% 
                    ungroup() %>% 
                    filter(Country == country_run)
                  )
  HCIaggs$Country[1] <- region_abbrev
  HCIaggs$Country[2] <- income_abbrev}

#Bind country and region/income data together
HCI <- HCIaggs  %>% 
  select(-c(5,6)) %>% 
  pivot_longer(.,3:4) %>% 
  rename("Gender" = name) %>% 
  as.data.frame() 
save(HCI,file = "HCI.RData")

#Rename HCI indicators to female/male
HCI[HCI=="HD.HCI.OVRL.FE"] <- "Female"
HCI[HCI=="HD.HCI.OVRL.MA"] <- "Male"    

HCI$Country <- factor(HCI$Country, levels = c(country_run,region_abbrev,income_abbrev))

#Create HCI plot
HCIplot <- 
  ggplot(HCI, aes(fill=Gender, y=value, x=Country)) + 
  geom_bar(position="dodge", stat="identity"
  )+
  geom_text(aes(label = round(value, 2)), 
            position = position_dodge(0.8),vjust = -0.1
            ,size = datasize
  )+
  theme_void()+
  theme(legend.position = "bottom",
        text = element_text(size = textsize),
        plot.margin = margin(5,5,10,0),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.text.x=element_text(),
        plot.title = element_text(margin=margin(0,0,15,0)))+
  scale_fill_manual(values=c(female,male))+
  labs(y = "",x = "",title = "Human Capital Index Score (0-1)",
       subtitle = paste("Indicator data from",
        ifelse(round(max(HCI$date),0)==floor(min(HCI$date)),
               floor(min(HCI$date)),
               paste(c(floor(min(HCI$date)),"to",ceiling(max(HCI$date))),collapse = " ")
               )))+
  ylim(0,1)

#Save HCI plot
ggsave("HCIplot.png",HCIplot,height = 4500/2.5,width=6400/2.5,units = "px")

#WBL
#Create WBL dataset
{wblcountry <- wbdata_long %>% 
    filter(name == "SG.LAW.INDX") %>% 
    filter(Country == country_run) %>% 
    select(-c(2,3)) %>% 
    na.omit() %>% 
    pivot_wider(.,names_from = c(1,3), values_from = 4) %>% 
    filter(date > 1989) %>% 
    mutate(Region = country_run)
  colnames(wblcountry) <- c("Year","Value","Region")}

{wblregion <- 
    wbdata_long %>% 
    filter(name == "SG.LAW.INDX") %>% 
    filter(region == region_run) %>% 
    select(-c(1,3,5)) %>% 
    na.omit() %>% 
    filter(date > 1989) %>% 
    group_by(.,Year = date) %>% 
    summarise(mean(value))%>% 
    mutate(Region = region_abbrev)
    colnames(wblregion) <- c("Year","Value","Region")}

{wblincome <- 
    wbdata_long %>% 
    filter(name == "SG.LAW.INDX") %>% 
    filter(income_level == income_run) %>% 
    select(-c(1,2,5)) %>% 
    na.omit() %>% 
    filter(date > 1989) %>% 
    group_by(.,Year = date) %>% 
    summarise(Value = mean(value))%>% 
    mutate(Region = income_abbrev)
  colnames(wblworld) <- c("Year","Value","Region")}

wbl_data <- rbind(wblcountry,wblregion,wblincome)
wbl_headtail <- wbl_data %>% 
  filter(Year %in% c(max(wbl_data$Year),min(wbl_data$Year)))
  
wbl_data$Region <- factor(wbl_data$Region, levels = c(country_run,region_abbrev,income_abbrev))
wbl_headtail$Region <- factor(wbl_headtail$Region, levels = c(country_run,region_abbrev,income_abbrev))

wbl_plot<- 
  wbl_data %>% 
  ggplot(.,aes(x=Year,y = Value, group = Region))+
  geom_line(aes(linetype = Region,color = Region),size = 2)+
  geom_point(data = wbl_headtail,aes(shape=Region, color = Region), size = 8)+
  scale_linetype_manual(values=c("solid","dashed", "dotted")) +
  scale_color_manual(values=c(female,'darkgrey', 'darkgrey'))+
  theme_void()+
  theme(legend.position = "bottom",
        text = element_text(size = textsize),
        plot.margin = margin(5,5,10,0),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        plot.title = element_text(margin=margin(0,0,15,0)),
        axis.text = element_text())+
  ggtitle("WBL Overall Index Score (0-100)")+
  theme(axis.text.y.right = element_text(size = textsize))

ggsave("wbl_plot.png",wbl_plot,height = 4500/2.5,width=6500/2.5,units = "px")

wbl_mean <- wbdata_long %>% na.omit() %>% 
  filter(region == region_run,
         name == 'SG.LAW.INDX',
         date == max(.$date))  
wbl_mean <- round(mean(wbl_mean$value),1)
save(wbl_mean, file = "wbl_mean.RData")


LFPdata2 <- wbdata_long %>% 
  filter(name == "SL.TLF.CACT.FE.ZS") %>% 
  filter(date %in% c(2010,2019)) %>% 
  pivot_wider(.,names_from = date, values_from = value) %>% 
  na.omit() %>% 
  mutate(Change = (.$`2019`-.$`2010`)/100) %>% 
  mutate(Group = ifelse(Country == country_run,country_run,
                        ifelse(region == region_run,region_abbrev,
                               "Other Countries")))

LFPdata2$Group <- factor(LFPdata2$Group, 
                         levels = c(country_run,
                                    region_abbrev,
                                    "Other Countries"))
LFPlabel <- LFPdata2 %>% filter(Country == country_run)

LFPplot2 <- LFPdata2 %>% 
  arrange(.$Change) %>% 
  mutate(Country=factor(Country, levels=Country)) %>% 
  ggplot(aes(x = Country,y = Change, fill = Group))+
  geom_bar(stat="identity")+
  geom_text(aes(label = ifelse(Country == country_run,
                               scales::percent(Change,accuracy = 0.1),""),
                vjust = ifelse(Change>0,-1,1)),size = datasize)+
  scale_fill_manual(values=c(female,male, 'darkgrey'))+
  theme_void()+
  theme(legend.position = "bottom",
        text = element_text(size = textsize),
        plot.margin = margin(5,5,10,0),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.y=element_blank(),
        plot.title = element_text(margin=margin(0,0,15,0)),
        axis.text = element_text())+
  labs(title = "Change in Female Labor Force Participation (%, 15+)",
          subtitle = "Indicator data from 2010 to 2019")+ 
  scale_y_continuous(labels = scales::percent_format(accuracy = 5L))

ggsave("LFPplot2.png",LFPplot2,height = 4500/2.5,width=4800,units = "px")


## Create link
link <- if(region_run=="Sub-Saharan Africa"){c('https://www.worldbank.org/en/programs/africa-gender-innovation-lab','AFR Gender Innovation Lab')}else{
  if(region_run=="East Asia & Pacific"){c('https://www.worldbank.org/en/programs/east-asia-and-pacific-gender-innovation-lab','EAP Gender Innovation Lab')}else{
    if(region_run=="Europe & Central Asia"){c('https://www.worldbank.org/en/region/eca/brief/gender',"ECA Gender Page")}else{
      if(region_run=="Latin America & Caribbean"){c('https://www.worldbank.org/en/programs/latin-america-and-the-caribbean-gender-innovation-lab','LAC Gender Innovation Lab')}else{
        if(region_run=="Middle East & North Africa"){c('https://www.worldbank.org/en/programs/mena-gender-innovation-lab','MENA Gender Innovation Lab')}else{
          if(region_run=="South Asia"){c('https://www.worldbank.org/en/programs/world-bank-south-asia-region-gender-innovation-lab','South Asia Gender Innovation Lab')}else{
            c('https://www.worldbank.org/en/topic/fragilityconflictviolence/overview#1',"Fragility, Conflict and Violence Page")
          }}}}}}
save(link, file = "link.RData")

link1 <- if(region_run=="Latin America & Caribbean"){
  c('https://documents1.worldbank.org/curated/en/524711645766347351/pdf/Colombia-Country-Gender-Scorecard.pdf',
    paste(country_run,'Gender Scorecard',collapse = " "),
    paste(": This report offers additional context about the gender dynamic in ",country_run,", from the Poverty and Equity Team.",collapse = "",sep = "")
    )}else{
      c('https://www.ifc.org/wps/wcm/connect/Topics_Ext_Content/IFC_External_Corporate_Site/Gender+at+IFC',
        'IFC Work in Gender',
        ': This page provides an overview of the work by IFC to promote gender equality in its global partnerships.')}
save(link1, file = "link1.RData")
