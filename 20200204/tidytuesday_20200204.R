#third day of tidy tuesday spring 2020
#Danielle Becker
#20200204

#clear dataframe
rm(list=ls())

#load libraries needed
### Load libraries ######
library(tidyverse)
library(ggmap)
library(sf)
library(png)
library(grid)
library(ggrepel)



#load data sheets
attendance <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/attendance.csv')
standings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/standings.csv')
games <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/games.csv')

view(standings)

#tally number wins =
wins.all <- standings %>% group_by(team) %>% tally(wins)

#rename team to state column 
names(wins.all)[names(wins.all)=="team"] <- "city"

## help from J Byrnes on how to get city names and lat/longs

#get my apis flowin'
register_google(key = 'AIzaSyBSKQsr5WiVHvKo4IsLv1fZ5EsJcMnpZ2A') ### use your own API
## Info on how here (https://www.r-bloggers.com/geocoding-with-ggmap-and-the-google-api/)

# #download the data and add geocoding
# #note: this takes a while, so, do this once, 

wins.all <- wins.all %>%
  cbind(geocode(paste(wins.all$city))) # pastes the city name and the state, separated by a comma and geocodes it

write.csv(x = wins.all, file = "20200204/cities.wins.csv") # save the csv

wins.all.ct <- wins.all %>%
  st_as_sf(coords = c("lon", "lat"), remove=FALSE)

saveRDS(wins.all.ct, "20200204/save.wins.all.RDS") # save the object
wins.all.ct <- readRDS("20200204/save.wins.all.RDS")

## Make a map

# MAKE A BASEMAP FROM A .SHP FILE:
# how to load a .shp file into R- this requires {sf}
states <- st_read(dsn = "20200204/states_21basic/states.shp") # load a simple state shape file
# the above code just tells st_read where the file is stored, currently stored in folder "cb_2017_us_state_20m" and the file name is " cb_2017_us_state_20m.shp"

states<- st_transform(states, crs= 4326) # transform the data from NAD 83 to WGS 84 you probably won't have to worry about this, but its good to know
st_crs(states) # check that coordinates were transformed- they are now in WGS84

# set the crs
 wins.all <-wins.all.ct %>%
   st_set_crs(4326)


# PLOT BASEMAP AND POINTS IN GGPLOT
  
wins.all %>%  # our dataframe with biking and walking info
  ggplot() +
  theme(panel.border = element_rect(fill=NA, color="black", size=3), #thick outline of plot
    panel.background = element_rect(fill="white"), # set background color
    panel.grid.major = element_line(color=NA))+ # remove gridlines
  geom_sf(data=states, color="black", show.legend = FALSE)+
  # add points for our stations where we caught Blue Lanternfish
  geom_point(aes(x=lon, y=lat, color=n), size=8, alpha=0.8) +
  scale_colour_gradient2() +
  xlab("Longitude")+
  ylab("Latitude")+
  xlim(-128, -55)+ # zoomed region
  ylim(25, 50)+
  labs(colour = "Number of Wins") +
 theme(legend.key.height = unit(1.0, "cm"),  # move legend and make it transparent
        # legend.position = c(0.95, 0.52),
       legend.background = element_blank(),
        legend.box.background = element_blank(),
        legend.key = element_blank())+
    ggsave(filename = "20200204/wins.over.years.png")


