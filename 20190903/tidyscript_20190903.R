#Second week of tidy tuesday
#Danielle Becker
#20190903


#clear dataframe
rm(list=ls())

#load libraries needed
library(tidyverse)
library(ggplot2)
library(gganimate)
library(transformr)
library(gifski)
library(here)

here()

#download Moore's Law: Transistors per microprocessor data to work with for tidy tuesday
cpu <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/cpu.csv")

gpu <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/gpu.csv")

ram <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/ram.csv")

#view data sheets
view(cpu)
view(gpu)
view(ram)

#new data frames for each by selecting columns 
cpu.dat <- cpu %>%
  select(transistor_count, date_of_introduction, process, area) 

cpu.dat$Type<-"cpu"

gpu.dat <- gpu %>%
  select(transistor_count, date_of_introduction, process, area)

gpu.dat$Type<-"gpu"

ram.dat <- ram %>%
  select(transistor_count, date_of_introduction, process, area)

ram.dat$Type<-"ram"

#rbind all data frames

all.dat <- rbind(ram.dat, gpu.dat, cpu.dat)

view(all.dat)

#make dat.frame column a factor
all.dat$Type <- as.factor(all.dat$Type)

#make dat.frame column a factor
all.dat$date_of_introduction <- as.integer(all.dat$date_of_introduction)

#omit all NA values
all.dat <- na.omit(all.dat)

#rename process to be capitalized
colnames(all.dat)[colnames(all.dat)=="process"] <- "Process"

# Make a ggplot, but add frame=year: one image per year
ggplot(all.dat, aes(transistor_count, area, size = Process, color = Type)) +
  geom_point() +
  scale_x_log10() +
  theme_bw() +
  # gganimate specific bits:
  labs(title = 'Year: {frame_time}', x = 'Area', y = 'Transistor Count') + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  transition_time(date_of_introduction) +
  shadow_mark() +
  ease_aes('linear')

# Save as gif:
anim_save("20190903/tidytuesday_20190903.gif")



