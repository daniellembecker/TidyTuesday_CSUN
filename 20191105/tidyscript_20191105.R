#Eleveenth week of tidy tuesday
#Danielle Becker
#20191105


#clear dataframe
rm(list=ls())

#load libraries needed
library(tidyverse)
library(ggplot2)
library(animation)
library(caTools)
library(gganimate)
library(transformr)
library(mapdata)
library(gifski)
library(maps)
library(usmap)
library(grid)
library(png)
library(magick)
library(here)

here()

#upload data set for coding
commute_mode <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-05/commute.csv")

#filter data set to include top 5 most populated states
#use == for one specific value in column, or %in% for multiple
filtered.commute.mode <-  commute_mode %>%
  filter(state %in% c("California", "Texas", "Florida", "New York", "Pennsylvania"))

#stacked barplot of states and percentages of each mode
plot <- ggplot(filtered.commute.mode, aes(fill=state, y=percent, x=mode)) + 
  geom_bar(position="fill", stat="identity") +
  theme_bw() +
  labs(x = 'Mode of Transportation', y = 'Percent') + 
  labs(fill = "State") +
  scale_y_continuous(expand = c(0,0), limits = c(0,1.3)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

#save as png to be used later for overlay of the gif
ggsave("20191105/plot.png")

#load both gif images to r: first is a bicycle gif
bicycle <- image_read("http://giphygifs.s3.amazonaws.com/media/bhSi84uFsp66s/giphy.gif") %>%
  image_scale("200x") %>%
  image_quantize(128)

length(bicycle)

bicycle

walking <- image_read("http://giphygifs.s3.amazonaws.com/media/omHPYZttAVAAw/giphy.gif") %>%
  image_quantize(100)

length(walking)

walking

#Read the image files into Rstudio
plot <- image_read("20191105/plot.png")

#Make a composite image that puts the  ggplot and walking gif together. Use the offset to move the gif.
frames <- image_composite(plot, walking, offset = "+0+2")

#Make a second composite image that puts the frames and bicycle gif together. Use the offset to move the gif.
frames2 <- image_composite(frames, bicycle, offset = "+0+0.5")

#Animate the frames and write to a new gif, this will take a long time
animation <- image_animate(frames2, fps = 10)
image_write(animation, "20191105/walking.gif")








