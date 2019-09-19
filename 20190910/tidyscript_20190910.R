#Third week of tidy tuesday
#Danielle Becker
#20190910


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

here()

#download Moore's Law: Transistors per microprocessor data to work with for tidy tuesday
tx_injuries <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/tx_injuries.csv")

safer_parks <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/saferparks.csv")

#rename state and city columns
names(safer_parks)[names(safer_parks)=="acc_state"] <- "abbr"
names(safer_parks)[names(safer_parks)=="acc_city"] <- "city"


#load in information for states data sheet 
data("statepop")
head(statepop)

#tally number injured for safer park num injured data 
safer.parks <- safer_parks %>% group_by(abbr) %>% tally(num_injured)

safer_parks <- left_join(safer.parks, safer_parks)

#combine safer parks and state pop data 
all.dat <- left_join(statepop, safer_parks)


plot_usmap(data = all.dat, values = "n", lines = "red") + 
  scale_fill_continuous(
    low = "light blue", high = "dark blue", name = "Number Individuals Injured", label = scales::comma
  ) + theme(legend.position = "top")

ggsave(filename = "20190910/amusement.injuries.png", device = "png", width = 10, height = 10)


