---
title: "Columbia Gender Brief"
output: pdf_document
---
![](gender-logo.png){height = 10%}
***
The brief provides a quick overview of the gender landscape in Colombia on some key indicators. Colombia has made notable improvements in improving the status outcomes of women and men in [outcome1], [outcome2], … [outcomeN]; closing gender gaps in [outcome1], [outcome2], … [outcomeN]. Persistent gaps remain in [outcome1], [outcome2], … [outcomeN]. Meanwhile, gender gaps emerge in [outcome1], [outcome2], … [outcomeN].



## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
wb_table %>% 
  select(-c(1,2)) %>% 
  head(.,nrow(.)-11) %>% 
  formattable(.,
              align = c("l","c","c","c","c","c","r"),
              list(
                    Measure = formatter("span", 
                    style = style(color = "grey",
                                  font.weight = "bold")),
                    area(col = `Country Baseline`:`Income Level`) ~ 
                    formatter("span", style = style(color = "grey")))
              )
```


<table class="table table-condensed">
 <thead>
  <tr>
   <th style="text-align:left;"> Measure </th>
   <th style="text-align:center;"> Country Baseline </th>
   <th style="text-align:center;"> Base Year </th>
   <th style="text-align:center;"> Performance </th>
   <th style="text-align:center;"> Year Measured </th>
   <th style="text-align:center;"> Region </th>
   <th style="text-align:right;"> Income Level </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">School enrollment, secondary, female (% net)                                                                           </span> </td>
   <td style="text-align:center;"> <span style="color: grey">78.3</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">80.2</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2018</span> </td>
   <td style="text-align:center;"> <span style="color: grey">79.1</span> </td>
   <td style="text-align:right;"> <span style="color: grey">83.9</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">School enrollment, secondary, male (% net)                                                                             </span> </td>
   <td style="text-align:center;"> <span style="color: grey">72.5</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">74.9</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2018</span> </td>
   <td style="text-align:center;"> <span style="color: grey">76.0</span> </td>
   <td style="text-align:right;"> <span style="color: grey">80.7</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Lower secondary completion rate, female (% of relevant age group)                                                      </span> </td>
   <td style="text-align:center;"> <span style="color: grey">98.5</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">82.7</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">82.3</span> </td>
   <td style="text-align:right;"> <span style="color: grey">90.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Lower secondary completion rate, male (% of relevant age group)                                                        </span> </td>
   <td style="text-align:center;"> <span style="color: grey">86.8</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">73.8</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">77.6</span> </td>
   <td style="text-align:right;"> <span style="color: grey">88.8</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">School enrollment, tertiary, female (% gross)                                                                          </span> </td>
   <td style="text-align:center;"> <span style="color: grey">41.3</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">59.0</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">61.7</span> </td>
   <td style="text-align:right;"> <span style="color: grey">63.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">School enrollment, tertiary, male (% gross)                                                                            </span> </td>
   <td style="text-align:center;"> <span style="color: grey">37.5</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">51.1</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">46.8</span> </td>
   <td style="text-align:right;"> <span style="color: grey">52.6</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Female share of graduates from Science, Technology, Engineering and Mathematics (STEM) programmes, tertiary (%)        </span> </td>
   <td style="text-align:center;"> <span style="color: grey">36.8</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2002</span> </td>
   <td style="text-align:center;"> <span style="color: grey">33.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2018</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Share of youth not in education, employment or training, female (% of female youth population)                         </span> </td>
   <td style="text-align:center;"> <span style="color: grey">32.8</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">32.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">29.5</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Share of youth not in education, employment or training, male (% of male youth population)                             </span> </td>
   <td style="text-align:center;"> <span style="color: grey">14.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">15.6</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">18.3</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Maternal mortality ratio (modeled estimate, per 100,000 live births)                                                   </span> </td>
   <td style="text-align:center;"> <span style="color: grey">85.0</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">83.0</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2017</span> </td>
   <td style="text-align:center;"> <span style="color: grey">74.0</span> </td>
   <td style="text-align:right;"> <span style="color: grey">41.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Births attended by skilled health staff (% of total)                                                                   </span> </td>
   <td style="text-align:center;"> <span style="color: grey">95.8</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2009</span> </td>
   <td style="text-align:center;"> <span style="color: grey">97.0</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2015</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Prevalence of HIV, female (% ages 15-24)                                                                               </span> </td>
   <td style="text-align:center;"> <span style="color: grey">0.1</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">0.1</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2020</span> </td>
   <td style="text-align:center;"> <span style="color: grey">0.1</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Prevalence of HIV, male (% ages 15-24)                                                                                 </span> </td>
   <td style="text-align:center;"> <span style="color: grey">0.1</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">0.1</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2020</span> </td>
   <td style="text-align:center;"> <span style="color: grey">0.1</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Contraceptive prevalence, modern methods (% of females ages 15-49)                                                     </span> </td>
   <td style="text-align:center;"> <span style="color: grey">72.9</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2009</span> </td>
   <td style="text-align:center;"> <span style="color: grey">75.9</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2015</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Labor force participation rate, female (% of female population ages 15+) (national estimate)                           </span> </td>
   <td style="text-align:center;"> <span style="color: grey">55.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">50.3</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2020</span> </td>
   <td style="text-align:center;"> <span style="color: grey">47.7</span> </td>
   <td style="text-align:right;"> <span style="color: grey">59.2</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Labor force participation rate, male (% of male population ages 15+) (national estimate)                               </span> </td>
   <td style="text-align:center;"> <span style="color: grey">81.0</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">75.9</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2020</span> </td>
   <td style="text-align:center;"> <span style="color: grey">71.2</span> </td>
   <td style="text-align:right;"> <span style="color: grey">76.8</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Account ownership at a financial institution or with a mobile-money-service provider, female (% of population ages 15+)</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:center;"> <span style="color: grey">42.5</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2017</span> </td>
   <td style="text-align:center;"> <span style="color: grey">52.0</span> </td>
   <td style="text-align:right;"> <span style="color: grey">69.3</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Account ownership at a financial institution or with a mobile-money-service provider, male (% of population ages 15+)  </span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:center;"> <span style="color: grey">49.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2017</span> </td>
   <td style="text-align:center;"> <span style="color: grey">58.6</span> </td>
   <td style="text-align:right;"> <span style="color: grey">77.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Vulnerable employment, female (% of female employment) (modeled ILO estimate)                                          </span> </td>
   <td style="text-align:center;"> <span style="color: grey">49.1</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">46.1</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">33.8</span> </td>
   <td style="text-align:right;"> <span style="color: grey">38.3</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Vulnerable employment, male (% of male employment) (modeled ILO estimate)                                              </span> </td>
   <td style="text-align:center;"> <span style="color: grey">47.7</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">45.8</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">33.4</span> </td>
   <td style="text-align:right;"> <span style="color: grey">35.6</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Women who were first married by age 18 (% of women ages 20-24)                                                         </span> </td>
   <td style="text-align:center;"> <span style="color: grey">23.0</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">23.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2015</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Adolescent fertility rate (births per 1,000 women ages 15-19)                                                          </span> </td>
   <td style="text-align:center;"> <span style="color: grey">76.8</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">64.3</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2019</span> </td>
   <td style="text-align:center;"> <span style="color: grey">61.2</span> </td>
   <td style="text-align:right;"> <span style="color: grey">29.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Proportion of seats held by women in national parliaments (%)                                                          </span> </td>
   <td style="text-align:center;"> <span style="color: grey">12.7</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">18.3</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2020</span> </td>
   <td style="text-align:center;"> <span style="color: grey">32.8</span> </td>
   <td style="text-align:right;"> <span style="color: grey">26.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Firms with female top manager (% of firms)                                                                             </span> </td>
   <td style="text-align:center;"> <span style="color: grey">12.1</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">18.9</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2017</span> </td>
   <td style="text-align:center;"> <span style="color: grey">20.1</span> </td>
   <td style="text-align:right;"> <span style="color: grey">19.1</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Proportion of women subjected to physical and/or sexual violence in the last 12 months (% of women age 15-49)          </span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:center;"> <span style="color: grey">18.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2015</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Firms with female participation in ownership (% of firms)                                                              </span> </td>
   <td style="text-align:center;"> <span style="color: grey">35.3</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">66.9</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2017</span> </td>
   <td style="text-align:center;"> <span style="color: grey">49.9</span> </td>
   <td style="text-align:right;"> <span style="color: grey">34.2</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> <span style="color: grey; font-weight: bold">Proportion of women who have ever experienced any form of sexual violence (% of women ages 15-49)                      </span> </td>
   <td style="text-align:center;"> <span style="color: grey">11.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">11.4</span> </td>
   <td style="text-align:center;"> <span style="color: grey">2010</span> </td>
   <td style="text-align:center;"> <span style="color: grey">NA</span> </td>
   <td style="text-align:right;"> <span style="color: grey">NA</span> </td>
  </tr>
</tbody>
</table>

## Including Plots

You can also embed plots, for example:

![plot of chunk pressure](figure/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
