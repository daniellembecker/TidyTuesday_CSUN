#tidy tuesday spring 2020
#Danielle Becker
#20200804

#clear dataframe
rm(list=ls())

#load libraries needed
library(tidyverse)
library(ggplot2)
library(PNWColors)
library(here)

#import energy data
energy_types <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-04/energy_types.csv')

#view data
view(energy_types)


#organized data frame to show only countries and energy usage from types for 2018
energy.dat <- energy_types %>%
              select(country_name, `2018`, type, `2017`, `2016`) 

#sum together the three years in data frame
energy.dat1 <- energy.dat %>% 
  group_by(type, country_name) %>% 
  summarise(Total = sum(`2018`, `2017`, `2016`, na.rm = TRUE))

#tally amount per energy type for each country

energy.dat.tally <- energy.dat1 %>%
                  group_by(type, country_name) %>% 
                  tally(Total)

#use pnw palette starfish
pal <- pnw_palette(name="Shuksan",n=8,type="discrete")

#make multiple pie charts in ggplot

ggplot(energy.dat.tally, aes(x="", y=n, group=type, color=type, fill=type)) +
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start=0) + facet_wrap(~ country_name, labeller=label_wrap_gen(width=10)) + #facet wrap by country, labeller will make sure labels fit in facet wrap  sections
  scale_fill_manual(values=pal) +
  scale_color_manual(values=pal) +
  labs(x= "", y = "") + #removce x and y labels
  labs(fill = "Energy Type") + #change legend title 
  guides(color = FALSE) + #remove color legend
  labs(title = "How European countries generated electricity from 2016 to 2018", face = "bold") + #plot title
  theme_bw() +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank(), 
        plot.title = element_text(face = "bold", size = 14), 
        legend.title = element_text(face = "bold", size = 12),
        legend.text=element_text(size=10))

ggsave(filename = "20200804/piechart_energy.png", width = 10, height = 10)


                    
      
  
  
  
  
  
