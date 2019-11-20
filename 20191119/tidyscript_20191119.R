#Twelfth week of tidy tuesday
#Danielle Becker
#20191105


#clear dataframe
rm(list=ls())

#load libraries
library(tidyverse)
library(gganimate)
library(transformr)
library(gifski)
library(ggimage)
library(wesanderson)
library(grid)
library(ggimage)
library(magick)
devtools::install_github("thebioengineer/tidytuesdayR")

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# Either ISO-8601 date or year/week works!

#upload dataset for tonight
tuesdata <- tidytuesdayR::tt_load("2019-11-19")
tuesdata <- tidytuesdayR::tt_load(2019, week = 47)

nz_bird <- tuesdata$nz_bird

#change vote rank to numeric
#change names of vote rank params in data sheet
nz_bird <- nz_bird %>% 
  mutate(vote_rank = recode(vote_rank, `vote_1` = 1, `vote_2` = 2, `vote_3` = 3, `vote_4` = 4,  `vote_5` = 5))


#tally voter rank for each bird species 
nz_bird_rank <- nz_bird %>% group_by(bird_breed, vote_rank) %>% tally(vote_rank)

#omit NAs from data sheet 
nz_bird_rank <- na.omit(nz_bird_rank)

nz_rank_vote <- nz_bird_rank %>%
  filter(vote_rank == 1) 

nz_rank_vote_birds <- nz_rank_vote %>%
  filter(bird_breed %in% c("Antipodean Albatross","Banded Dotterel", "Black Robin", "Blue Duck", 
                           "Fantail",  "Kākā","Kākāpō", "Kea", "Kererū", "Morepork", "New Zealand Falcon"
                           ,"Tūī", "Yellow-eyed penguin"))


#make animated map of what bird was there on each hour of the day 
#make a pie chart of highest ranked bird breeds 
ggplot(nz_rank_vote_birds, aes(x="", y=n, fill = bird_breed)) +
  geom_bar(stat="identity", width=1) +
  theme_void() +
  coord_polar("y", start = 0)+ 
  labs(fill = "Bird Breed") 

#save as png to be used later for overlay of the gif
ggsave("20191119/bird.plot.png")

#Read the image files into Rstudio
bird.plot <- image_read("20191119/bird.plot.png")

#load penguin photo
penguin <- image_read("20191119/penguin.png") %>%
  image_scale("200x") %>%
  image_quantize(128)

length(penguin)

penguin

#save penguin on pie chart
bird.plot.penguin <- image_composite(bird.plot, penguin, offset = "+800+700")

#save as png to upload again
image_write(bird.plot.penguin, "20191119/bird.plot.penguin.png")

#Read the image files into Rstudio
bird.plot.final <- image_read("20191119/bird.plot.penguin.png")

#load kakato photo
kakapo <- image_read("20191119/kakapo.png") %>%
  image_scale("200x") %>%
  image_quantize(128)

length(kakapo)

kakapo


#save penguin on pie chart
bird.plot.final <- image_composite(bird.plot.final, kakapo, offset = "+500+1300")


#save as png to upload again
image_write(bird.plot.final, "20191119/bird.plot.final.png")






