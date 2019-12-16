library(dplyr)
library(plotly)
library(ggplot2)

player_data <- read.csv("../data/Player_Stats.csv", stringsAsFactors = FALSE)

newdf <- select(player_data, Pos, Conf, Totals.PTS)

newdf <- newdf %>%
  filter(Conf == "Pac-12") %>%
  filter(Totals.PTS > 0) %>%
  group_by(Pos) %>%
  summarise(Points = mean(Totals.PTS))

pie_Plot <- plot_ly(newdf, labels = ~Pos, values = ~Points,
             type = 'pie') %>%
  layout(title = 'Average Points Per Season by Player Position in Pac 12 Conference',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
