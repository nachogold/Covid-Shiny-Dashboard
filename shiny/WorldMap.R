paises_package <- c("Antigua","Bonaire","Virgin Islands",
                    "Republic of the Congo",
                    "Ivory Coast",
                    "Democratic Republic of the Congo",
                    "Faroe Islands",
                    "Saint Kitts",
                    "Grenadines",
                    "Sint Maarten",
                    "Timor-Leste",
                    "Trinidad",
                    "UK",
                    "USA")

paises_df <- c("Antigua and Barbuda",
               "Bonaire Sint Eustatius and Saba",
               "British Virgin Islands",
               "Congo",
               "Cote d'Ivoire",
               "Democratic Republic of Congo",
               "Faeroe Islands",
               "Saint Kitts and Nevis",
               "Saint Vincent and the Grenadines",
               "Sint Maarten (Dutch part)",
               "Timor",
               "Trinidad and Tobago",
               "United Kingdom",
               "United States"
)

reemplaza_pais <- function(a,b) {
  for (i in length(a)) {
    WorldData <- WorldData %>% mutate(region = replace(region,region==a[i],b[i]))
  }
}
#world map

mapData=df %>%
  group_by(location) %>%
  # slice(which.max(df$date))   #último dia de info
  filter(date==as.Date("2020-08-05"))
#summary(unique(mapData$location))

paises_df[1]

WorldData <- map_data('world') %>% filter(region != "Antarctica") %>% fortify
WorldData[WorldData==paises_package[1]] <- paises_df[1]
WorldData %>% filter(region == "Antigua and Barbuda")

WorldData <- reemplaza_pais(paises_package,paises_df)

Combined = WorldData[mapData$location %in% WorldData$region,]

Combined$value = mapData$total_cases_per_million[match(Combined$region, mapData$location)]

x11()

ggplot(Combined, aes(x=long, y=lat, group = group, fill = value)) + 
  geom_polygon(colour = "white") +
  scale_fill_continuous(low = "pink",
                        high = "blue",
                        guide="colorbar") +
  theme_bw()  +
  labs(fill = "Cases per 1M" ,title = "Total cases per million", x="", y="") +
  scale_y_continuous(breaks=c()) +
  scale_x_continuous(breaks=c()) +
  theme(panel.border =  element_blank())