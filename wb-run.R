library(knitr)
library(wbstats)

source('wb-load.R')
source('wb-functions.R')

for(i in c('Thailand','Brazil','France','Kenya','China','Colombia')){

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

