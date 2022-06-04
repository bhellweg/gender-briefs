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
baseyear <- 2010
latestyear <- 2020

#CREATE HCI AND LFP CHARTS

#Create HCI country dataset

HCIdata <- wbdata_long %>% 
  filter(name %in% c("HD.HCI.OVRL.FE",'HD.HCI.OVRL.MA')) %>% 
  pivot_wider(.,names_from = name, values_from = value) %>% 
  na.omit() %>% 
  filter(date == latestyear) 

HCIbaseline <- wbdata_long %>% 
  filter(name %in% c("HD.HCI.OVRL.FE",'HD.HCI.OVRL.MA')) %>% 
  pivot_wider(.,names_from = name, values_from = value) %>% 
  na.omit() %>% 
  filter(date == baseyear) 

#HCI
#Create HCI aggregates data
{  
HCIaggs <- rbind(HCIdata %>% 
                    filter(region == region_run) %>% 
                    group_by(region) %>% 
                    summarise(across(everything(),mean)),
                 HCIdata %>% 
                    filter(income_level == income_run) %>% 
                    group_by(income_level) %>% 
                    summarise(across(everything(),mean)),
                 HCIdata %>% 
                    filter(Country == country_run))
if(nrow(HCIaggs)>=2){HCIaggs$Country[1] <- region_abbrev
HCIaggs$Country[2] <- income_abbrev}else{
  if(is.na(HCIaggs$region)){HCIaggs$Country[1] <- income_abbrev}
  if(is.na(HCIaggs$income_level)){HCIaggs$Country[1] <- region_abbrev}}

#Bind country and region/income data together
HCI <- HCIaggs  %>% 
  pivot_longer(.,5:6) 
save(HCI,file = "HCI.RData")

HCIbaseaggs <- rbind(HCIbaseline %>% 
                   filter(region == region_run) %>% 
                   group_by(region) %>% 
                   summarise(across(everything(),mean)),
                 HCIbaseline %>% 
                   filter(income_level == income_run) %>% 
                   group_by(income_level) %>% 
                   summarise(across(everything(),mean)),
                 HCIbaseline %>% 
                   filter(Country == country_run))
if(nrow(HCIbaseaggs)>=2){HCIbaseaggs$Country[1] <- region_abbrev
                        HCIbaseaggs$Country[2] <- income_abbrev}else{
if(is.na(HCIbaseaggs$region)){HCIbaseaggs$Country[1] <- income_abbrev}
if(is.na(HCIbaseaggs$income_level)){HCIbaseaggs$Country[1] <- region_abbrev}}

#Bind country and region/income data together
HCIbase <- HCIbaseaggs  %>% 
  pivot_longer(.,5:6)
  }

#Rename HCI indicators to female/male
HCI[HCI=="HD.HCI.OVRL.FE"] <- "Female"
HCI[HCI=="HD.HCI.OVRL.MA"] <- "Male"
HCIbase[HCIbase=="HD.HCI.OVRL.FE"] <- "Female"
HCIbase[HCIbase=="HD.HCI.OVRL.MA"] <- "Male"

HCI$Country <- factor(HCI$Country, levels = c(country_run,region_abbrev,income_abbrev))
HCIbase$Country <- factor(HCIbase$Country, levels = c(country_run,region_abbrev,income_abbrev))

#Create HCI plot
HCIplot <- 
  ggplot(HCI, aes(fill=name, y=value, x=Country)) + 
  geom_bar(position="dodge", stat="identity")+
  geom_text(aes(label = round(value, 2),y = 0.1,fontface = "bold"), 
            position = position_dodge(0.9),
            color = "white",size = datasize)+
  scale_fill_manual(values=c(female,male))+
  geom_point(data = HCIbase,
             aes(group=name, y=value, 
             color = paste(baseyear,"Value")),
             position = position_dodge(0.9),shape = 23,
             fill = "darkgrey",size = 8)+
  scale_color_manual(values = 1, "")+
  theme_void()+
  theme(legend.position = "bottom",
        text = element_text(size = textsize),
        plot.margin = margin(5,5,10,0),
        legend.box.margin=margin(10,0,0,0),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.text.x=element_text(),
        legend.title = element_blank(),
        plot.title = element_text(margin=margin(0,0,15,0)))+
  labs(y = "",x = "",title = "Human Capital Index Score (0-1)",
       subtitle = paste("Baseline compared to",max(HCI$date),
                        collapse = " "),
       caption = if(is.na(HCI[[6]][6])){
                        paste(country_run,"values not available.")}
               )+ylim(0,1)

#Save HCI plot
ggsave("HCIplot.png",HCIplot,height = 4500/2.5,width=6400/2.5,units = "px")


# LFP Second Plot
#use latest data point
LFPdata <- wbdata_long %>% 
  filter(name == "SL.TLF.CACT.FE.ZS") %>% 
  filter(date %in% c(baseyear,latestyear)) %>% 
  pivot_wider(.,names_from = date, values_from = value) %>% 
  na.omit() %>% 
  mutate(Change = (`2020`-`2010`)/100) %>% 
  mutate(Group = ifelse(Country == country_run,country_run,
                        ifelse(region == region_run,region_abbrev,
                               "Other Countries")))

LFPdata$Group <- factor(LFPdata$Group, 
                         levels = c(country_run,
                                    region_abbrev,
                                    "Other Countries"))
LFPlabel <- LFPdata %>% filter(Country == country_run)

LFPplot <- LFPdata %>% 
  arrange(.$Change) %>% 
  mutate(Country=factor(Country, levels=Country)) %>% 
  ggplot(aes(x = Country,y = Change, fill = Group))+
  geom_bar(stat="identity")+
  geom_text(aes(label = ifelse(Country == country_run,
                               scales::percent(Change,accuracy = 0.1,
                                               suffix = " p.p.",
                                               prefix = paste(country_abbrev,":",
                                                              sep = "")),""),
                y = ifelse(Change>0,-0.025,.025)),size = datasize)+
  scale_fill_manual(values=c(male,'grey30', 'grey'))+
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
        legend.title = element_blank(),
        axis.text = element_text())+
  labs(title = paste("Change in Female Labor Force Participation ",baseyear,"-",latestyear," (p.p.)",sep=""),
          subtitle = "Ages 15+")+ 
  scale_y_continuous(labels = scales::percent_format(accuracy = 5L,
                                                     suffix = " p.p. "))

ggsave("LFPplot.png",LFPplot,height = 4500/2.5,width=4800,units = "px")

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

scorecardlink <- {if(country_run == "Antigua and Barbuda"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/822421645769028203/antigua-and-barbuda-country-gender-scorecard'}
if(country_run == "Argentina"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/559901645768439086/argentina-country-gender-scorecard'}
if(country_run == "Belize"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/536991645768064239/belize-country-gender-scorecard'}
if(country_run == "Bolivia"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/234681645767636494/bolivia-country-gender-scorecard'}
if(country_run == "Brazil"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/179551645767119421/brazil-country-gender-scorecard'}
if(country_run == "Chile"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/140561645766744649/chile-country-gender-scorecard'}
if(country_run == "Colombia"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/524711645766347351/colombia-country-gender-scorecard'}
if(country_run == "Costa Rica"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/336261645765964871/costa-rica-country-gender-scorecard'}
if(country_run == "Dominica"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/107461645707836870/dominica-country-gender-scorecard'}
if(country_run == "Dominican Republic"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/993591645707379790/dominican-republic-country-gender-scorecard'}
if(country_run == "Ecuador"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/493161645706846754/ecuador-country-gender-scorecard'}
if(country_run == "El Salvador"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/574731645703818587/el-salvador-country-gender-scorecard'}
if(country_run == "Grenada"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/321381645693529836/grenada-country-gender-scorecard'}
if(country_run == "Guatemala"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/804221645693063418/guatemala-country-gender-scorecard'}
if(country_run == "Guyana"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/393971645692660417/guyana-country-gender-scorecard'}
if(country_run == "Haiti"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/702001645692150392/haiti-country-gender-scorecard'}
if(country_run == "Honduras"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/925751645691589621/honduras-country-gender-scorecard'}
if(country_run == "Jamaica"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/824961645691156835/jamaica-country-gender-scorecard'}
if(country_run == "Mexico"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/159831645690741028/mexico-country-gender-scorecard'}
if(country_run == "Nicaragua"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/567841645801215681/nicaragua-country-gender-scorecard'}
if(country_run == "Panama"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/177941645689412347/panama-country-gender-scorecard'}
if(country_run == "Paraguay"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/763811645686131959/paraguay-country-gender-scorecard'}
if(country_run == "Peru"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/596511645685683159/peru-country-gender-scorecard'}
if(country_run == "St. Kitts and Nevis"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/221291645684846946/saint-kitts-and-nevis-country-gender-scorecard'}
if(country_run == "St. Lucia"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/380831645684367421/saint-lucia-country-gender-scorecard'}
if(country_run == "St. Vincent and the Grenadines"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/496961645683705003/saint-vincent-and-the-grenadines-country-gender-scorecard'}
if(country_run == "Suriname"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/614931645682940490/suriname-country-gender-scorecard'}
if(country_run == "Trinidad and Tobago"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/977661645682267523/trinidad-and-tobago-country-gender-scorecard'}
if(country_run == "Uruguay"){'https://documents.worldbank.org/en/publication/documents-reports/documentdetail/967701645681741347/uruguay-country-gender-scorecard'}}

link1 <- if(!is.null(scorecardlink)){
  c(scorecardlink,
    paste(country_run,'Gender Scorecard',collapse = " "),
    paste(": This report offers additional context about the gender dynamic in ",country_run,", from the Poverty and Equity Team.",collapse = "",sep = "")
    )}else{
      c('https://www.ifc.org/wps/wcm/connect/Topics_Ext_Content/IFC_External_Corporate_Site/Gender+at+IFC',
        'IFC Work in Gender',
        ': This page provides an overview of the work by IFC to promote gender equality in its global partnerships.')}
save(link1, file = "link1.RData")
