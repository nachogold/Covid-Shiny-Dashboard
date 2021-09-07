library(tidyverse)
library(shinythemes)
library(maps)

#Para la version online traer el dataset de github
urlfile<-"https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv"
df<-read.csv(urlfile)

#Usar DF local en caso que no funcione github
#df <- read.csv("C:/Users/Nacho/Desktop/Data Science/Proyectos/COVID con Feli/owid-covid-data.csv")

df$date <- as.Date(df$date)

# list of countries
countries <- unique(df$location)

graph_options <- list("Total Cases per Million" = "total_cases_per_million",
     "Total Deaths per Million" = "total_deaths_per_million",
     "Total Tests per Thousand" = "total_tests_per_thousand")

# Dataframes heatmap ------------------------------------------------------

paises_package <- c("Antigua","Bonaire","Virgin Islands", "Republic of the Congo","Ivory Coast",
                    "Democratic Republic of the Congo","Faroe Islands","Saint Kitts","Grenadines",
                    "Sint Maarten","Timor-Leste","Trinidad","UK","USA")

paises_df <- c("Antigua and Barbuda","Bonaire Sint Eustatius and Saba","British Virgin Islands",
               "Congo","Cote d'Ivoire","Democratic Republic of Congo","Faeroe Islands",
               "Saint Kitts and Nevis","Saint Vincent and the Grenadines","Sint Maarten (Dutch part)",
               "Timor","Trinidad and Tobago","United Kingdom","United States")

mapData <- df %>%
  group_by(location) %>%
  filter(date==as.Date(Sys.Date()-1))

WorldData <- map_data('world') %>% filter(region != "Antarctica")

#Reemplazamos para el caso particular de Hong Kong
#WorldData <- WorldData %>% filter(subregion=="Hong Kong") %>% mutate(region = replace(region,region=="China","Hong Kong"))

#Reemplazamos los demas paises
for (i in (1:length(paises_package))) {
  WorldData[WorldData==paises_package[i]] <- paises_df[i]
}

Combined <- WorldData[mapData$location %in% WorldData$region,]