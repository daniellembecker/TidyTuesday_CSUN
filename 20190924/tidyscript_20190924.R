#fifth week of tidy tuesday
#Danielle Becker
#20190924


#clear dataframe
rm(list=ls())

#load libraries needed
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plotly)
library(here)

here()

#download data file for this week
school_diversity <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-24/school_diversity.csv")

#omit NAs found in the data set
school_diversity <- na.omit(school_diversity)


#need to reorganize data sheet so race will be in one column
SD_organized <- school_diversity %>%
  select(AIAN, Asian, Black, Hispanic, White, Multi, SCHOOL_YEAR, ST, diverse) %>%
  gather(race,value, (AIAN:Multi))

view(SD_organized)

datasum.SD <- SD_organized %>% 
  group_by(ST, race) %>% 
  summarize(value = mean(value, na.rm = TRUE))

#get average proportions of race by state and by diversity categorization
view(datasum.SD)

#want to mak donut chart showing states and proorations of races, and how diverse each is
# Compute percentages
datasum.SD$fraction = datasum.SD$value / sum(datasum.SD$value)

datasum.SD$percentage = datasum.SD$fraction * 100


p <- plot_ly(datasum.SD, x = ~race, y = ~ST, type = 'sunburst') 
add_markers(datasum.SD, color = ~percentage, size = ~percentage)










ggplot(datasum.SD, aes(x = race, y = percentage, fill = ST))+
  geom_bar(stat = "identity")+
  coord_polar(theta="y")


ggplot(datasum.SD, aes(x = race, y = ST, fill = percentage, alpha =race)) +
  geom_col(width = 1, color = "gray90", size = 0.25, position = position_stack()) +
  #geom_text(aes(label = race ), size = 2.5, position = position_stack(vjust = 0.5)) +
  coord_polar(theta = "y") 


# Compute the cumulative percentages (top of each rectangle)
datasum.SD$ymax = cumsum(datasum.SD$fraction)

# Compute the bottom of each rectangle
datasum.SD$ymin = c(0, head(datasum.SD$ymax, n=-1))

# Make the plot
ggplot(datasum.SD, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=race)) +
  geom_rect() +
  coord_polar(theta="y") + # Try to remove that to understand how the chart is built initially
  xlim(c(2, 4)) # Try to remove that to see how to make a pie chart





