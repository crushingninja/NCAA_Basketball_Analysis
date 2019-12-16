library(dplyr)
library(plotly)
library(ggplot2)

player_data <- read.csv("../data/Player_Stats.csv", stringsAsFactors = FALSE)
player_data$STL_BLK <- player_data$Totals.STL + player_data$Totals.BLK
player_data$hover <- paste("Player Name: ", player_data$Player, "<br>", "School: ", 
                           player_data$School, sep = "")

player_data <- player_data %>%
  filter(Conf == "Pac-12")

plot <- ggplot(player_data, aes(STL_BLK, Totals.PF, color = Pos, text = hover)) +
  geom_jitter() +
  labs(title =" Steals & Blocks vs Total Personal Fouls by Player Position", x = "Steals and Blocks", 
       y = "Personal Fouls")

plot <- ggplotly(plot)

get_jitter_plot <- function() {
  return(plot)
}
