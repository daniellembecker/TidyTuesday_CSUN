#First day of tidy tuesday
#Danielle Becker
#20190827


#load libraries needed
library(tidyverse)

#download simpsons data to work with for tidy tuesday
simpsons <- readr::read_delim("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-27/simpsons-guests.csv", delim = "|", quote = "")
view(simpsons)

#how often a guest star appears in episodes listed

