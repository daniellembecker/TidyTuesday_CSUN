#Second day of tidy tuesday spring 2020
#Danielle Becker
#20200128


#load libraries needed
library(tidyverse)
library(ggplot2)
library(data.tree)
library(networkD3)

#load data sheet
sf_trees <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-28/sf_trees.csv')

#make new column with common names and scientific seperate
trees <- sf_trees %>%
  separate(species, into = c("scientific.name", "common.name"), sep = " :: ") %>%
  na.omit()

#convert year character to as.numeric 
as.numeric(as.character(year))

#seperate scientific name with genus, street name and place
trees.genus <- trees %>%
  separate(scientific.name, into = c("genus", "species.specific"), sep = " ") %>%
  separate(address, into = c("street.num", "street.name"), sep = " ") %>%
  separate(site_info, into = c("general.place", "specific.place", "more.specific.place"), sep = ":") %>%
  separate(date, into = c("year", "day", "month"), sep = "-") %>%
  na.omit()

#convert year character to as.numeric 
trees.genus$year<-as.numeric(trees.genus$year)

#look at all trees planted before 2000s
trees.final <- trees.genus %>%
  filter(year < "2000") 
  

#define the hierarchy (Session/Room/Speaker)
trees.final$pathString <- paste("San Francisco", trees.final$caretaker, trees.final$general.place, trees.final$genus, sep="|")

#convert to Node
useRtree <- as.Node(trees.final, pathDelimiter = "|")

#plot with networkD3
useRtreeList <- ToListExplicit(useRtree, unname = TRUE)
radialNetwork( useRtreeList)

