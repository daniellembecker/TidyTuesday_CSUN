#First day of tidy tuesday
#Danielle Becker
#20190827


#load libraries needed
library(tidyverse)
library(ggplot2)
library(devtools)
library(extrafont)
devtools::install_github("Ryo-N7/tvthemes")
loadfonts()



#download simpsons data to work with for tidy tuesday
simpsons <- readr::read_delim("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-27/simpsons-guests.csv", delim = "|", quote = "")
view(simpsons)

#how often a guest star appears in each season 
#make season numeric
simpsons$season <- as.numeric(simpsons$season)

#tally season data
simpson.data <- simpsons %>%
  na.omit(season) %>%
  group_by(season, guest_star) %>%
  tally()
  
view(simpson.data)


ggplot(data=simpson.data, aes(x=season, y=n)) +
  geom_bar(stat="identity") +
  theme_classic()

ggplot(simpson.data, aes(season, n)) + 
  geom_point() +
  theme_classic()+
  scale_fill_simpsons() +
  labs(x = "Season",
       y = "Number of guest stars in season") +
  theme_simpsons(title.font = "Akbar",
                 text.font = "Akbar",
                 axis.text.size = 8)

ggsave(filename = "20190827/simpsons.png", device = "png", width = 50, height = 20)
  

