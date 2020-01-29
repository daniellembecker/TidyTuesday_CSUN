#First day of tidy tuesday spring 2020
#Danielle Becker
#20200121


#load libraries needed
library(tidyverse)
library(ggplot2)
library(plotly)
library(gganimate)


#download simpsons data to work with for tidy tuesday
spotify_songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')
view(spotify_songs)

#filter out the dance playlists to rank dance playlists danceability
#use seperate function to split type(dance) and genre(remix)
#dance.songs <- spotify_songs %>%
  #separate(playlist_name, into = c("type", "genre"), sep = " ")

#make new data frame with just playlists labeled dance
#dance.songs.2 <- dance.songs %>%
 # filter(type == "Dance")

#make bubble plot showing most highest danceability artist and popularity
#ggplot(dance.songs.2, aes(x=danceability, y=loudness, size = track_popularity)) +
  #geom_point(alpha=0.7) 




