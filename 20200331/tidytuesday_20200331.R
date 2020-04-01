#tidy tuesday spring 2020
#Danielle Becker
#20200331

#clear dataframe
rm(list=ls())

#load libraries needed
library(tidyverse)
library(ggplot2)
library(gganimate)
library(transformr)
library(mapdata)
library(gifski)
library(maps)
library(usmap)
devtools::install_github("pdil/usmap")
devtools::install_github("UrbanInstitute/urbnmapr")
library(here)

# Get the Data

brewing_materials <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/brewing_materials.csv')
beer_taxed <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/beer_taxed.csv')
brewer_size <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/brewer_size.csv')
beer_states <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/beer_states.csv')


#load in information for states data sheet 
data("statepop")
head(statepop)

#tally number of barrels produced by states from 2008 to 2019
beer.state <- beer_states %>% group_by(state) %>% tally(barrels)

plot_usmap(data = beer.state, values = "n", lines = "red") + 
  scale_fill_continuous(low = "light blue", high = "dark blue", name = "Barrels of Beer Produced (2008 - 2019)", label = scales::comma) + 
  theme(legend.position = "top") + guides(fill = guide_colorbar(barwidth = 20, barheight = 2, 
                 title.position = "top", title.hjust = 0.5, title.vjust = 1.0, nbin = 20)) +
  theme(legend.text=element_text(size=8, face = "bold"), legend.title = element_text(size = 12, face="bold"))


ggsave(filename = "20200331/beer.per.state.png", device = "png", width = 10, height = 10)

