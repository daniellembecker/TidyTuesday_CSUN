#tidy tuesday spring 2020
#Danielle Becker
#20200407

#clear dataframe
rm(list=ls())

#load libraries needed
library(ggplot2)
library(scico)
library(tidyverse)
library(ghibli)
library(wesanderson)
library(here)


# Get the Data

tdf_winners <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-07/tdf_winners.csv')

#make new column with common names for year seperate
tdf <- tdf_winners %>%
  separate(start_date, into = c("year", "month", "day "), sep = "-") 


#make bar plot of the winners per country over the years

ggplot(tdf, aes(x = birth_country, y = time_overall, fill = birth_country)) + 
  geom_boxplot() +
  scale_fill_scico_d(palette = 'tokyo') +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = "Birth Country",
       y = "Overall Race Times") + 
  theme(legend.position = "none")

ggsave(filename = "20200407/race times per country.png")




