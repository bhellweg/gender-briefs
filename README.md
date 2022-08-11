# World Bank Gender Briefings Document Automation

## Project Description 
This project produces two page briefings for every country in the World Bank service area on their progress towards gender equality and sustainable development. The automated report offers measures, charts, and factoids for each country to introduce users to the Gender Data Portal's wide range of useful content. This project is meant to be rerun at regular intervals in order to offer timely data using the World Bank API. The first round of briefings was produced between April and June 2022.

## Author
Brendan Hellweg (github.com/bhellweg)

Credit to the World Bank HCI team, whose one-pager and two-pager code was useful for building the document to World Bank style.

## Files
- wb-run.R: This script calls each of the other scripts in order to produce the final documents. It is the only script that needs to be opened unless you're making edits or looking to understand how the system works. 
- wb-load.R: This script loads each of the key datasets and performs basic manipulations, including renaming some countries from the API format. This file takes the longest time to load of any script because it is calling a large dataset from the World Bank API.
- wb-functions.R: This script creates functions for the rest of the project, which are particularly useful for creating the table on page 1. 
- wb-select.R: This script picks the measures used for each country, defines its region and income group, and sets several formatting characteristics based on the measures selected. 
- tables.R: This script generates a full and customized table for the country performance, customizing based on data availability.
- charts.R: This script produces two charts for the brief and sets the language for the links at the end of page 2.
- factoid.R: This script produces up to five sentences based on a series of data availability logic for the "Unpacking the Numbers" section on page 2.
- Gender-Briefs.Rmd: This Markdown script produces the formatted report.
- measure-list.xlsx: This spreadsheet offers the full list of measures from which the wb-select script draws.
- factoid-logic.xlsx: This spreadsheet lists the indicators and prioritization for the factoid script.
- pdf (folder): This folder has pdfs of every country flag.
- icon (folder): This folder has icons for the WBL section as well as the arrows for the table.

## Using the Code
This project can be deployed locally in a few hours on a personal computer. You should download all content and set your working directory to the folder where it is all housed. wb-run lists the files in the right order to load all data and generate the reports. Topics to note:

- It takes a long time to run wb-load.R and occasionally the WB API will time out if your connection is slow. For that reason, I recommend running that file command by command to identify any cases where it is timing out. 
- KableExtra, the package I used to format the tables, doesn't allow an ampersand in the link. Initially, I wanted to link to the country-specific data for each indicator, but the link contained an ampersand. If there's a clean fix to this--or if the Gender Data Portal edits its links, I've left the function to edit the links in the table commented out.

Be sure to download the full repository before running the code, as images and icons are stored in the folders attached in this repository.

## API
Data for this project comes from the World Bank API using the `wbstats` package. It is an open API, so no preauthorization or password is required.

## Updates
This project will receive intermittent updates as it is rerun over time. Significant changes will be noted here.
