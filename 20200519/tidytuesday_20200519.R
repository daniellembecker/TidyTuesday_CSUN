#tidy tuesday spring 2020
#Danielle Becker
#20200519

#clear dataframe
rm(list=ls())

#load libraries needed

library(tidyverse)
library(base)
library(grid)
library(ggpubr)
library(ggthemes)
library(ggimage)
library(dplyr)
library(emojifont)
library(imager)
library(png)
library(ggplot2)
library(here)

#load data for volleyball week
vb_matches <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-19/vb_matches.csv', guess_max = 76000)
 
view(vb_matches)

#make lollipop plot over image of volleyball court


#group by winners vs. losers, sum by aces and blocks, two winners and two losers, set x and y points, x for winners 1.2, x loser 
#average of aces and blocks winners vs. losers 
#select only columns you want for data frame, two winners and losers to long, all stacked on top, seperate grouping column to pull out w and l's, summarize by mean of aces and blocks 

vb_specific <- select(vb_matches, w_p1_tot_aces, w_p1_tot_blocks, w_p2_tot_aces, w_p2_tot_blocks, l_p1_tot_aces, l_p1_tot_blocks, l_p2_tot_aces, l_p2_tot_blocks)

#convert to long format
data_long <- gather(vb_specific, condition, measurement, w_p1_tot_aces, w_p1_tot_blocks, w_p2_tot_aces, w_p2_tot_blocks, l_p1_tot_aces, l_p1_tot_blocks, l_p2_tot_aces, l_p2_tot_blocks, factor_key=TRUE)

view(data_long)

#split to have column with w and l
vb_next <- data_long %>%
  separate(condition, into = c("outcome", "player", "type", "move"), sep = "_") %>%
  na.omit()

#delete two rows for p1 and tot
vb_next1 <- vb_next[ -c(3) ]

#group by outcome and move and take the average of for w and l and for blocks and aces
datasum.vb <- vb_next1 %>% 
  group_by(outcome, move) %>% 
  summarise(measurement = mean(measurement, na.rm = TRUE))

#make column with x andx y coords in data frame
datasum.vb$x <- c(1.2, 1.2, 1.8, 1.8)
datasum.vb$y <-  c(1.25, 1.75, 1.25, 1.75)

#add image to data frame to pull into plot later
datasum.vb$image_path = "20200519/volleyball.png"

#view datasum
datasum.vb

#import my background image
img <- readPNG("20200519/court.png")


#make ggplot with background image
ggplot()+ 
  background_image(img) +
  xlim(1:2) +  #set limits for background image on ggplot
  ylim(1:2) +
  geom_point(aes(x = datasum.vb$x, y =datasum.vb$y, size = datasum.vb$measurement), color = "white") + #add set points for averages
  geom_image(aes(image = datasum.vb$image_path), x = datasum.vb$x, y =datasum.vb$y, 
             size = (datasum.vb$measurement)/10) + #add image to feom_points, reference size 
  annotate("text", label = "Losers", x = 1.2, y = 1.93, color = "black", size = 8, fontface = 2) + #add text to plot
  annotate("text", label = "Winners", x = 1.81, y = 1.93, color = "black", size = 8, fontface = 2) +
  annotate("label", label = "Blocks", x = 1.805, y = 1.6, color = "black", size = 4, fontface = 2) +
  annotate("label", label = "Blocks", x = 1.2, y = 1.65, color = "black", size = 4, fontface = 2) + #add text to plot, chnage to "labels" to put box around text
  annotate("label", label = "Aces", x = 1.2, y = 1.17, color = "black", size = 4, fontface = 2) +
  annotate("label", label = "Aces", x = 1.805, y = 1.15, color = "black", size = 4, fontface = 2) +
  theme(legend.position = "none", axis.title = element_blank(), axis.text = element_blank(), 
        axis.ticks = element_blank())  #remove acces labels and legend

ggsave(filename = "20200519/volleyballcourt.png", device = "png", width = 6, height = 5)





