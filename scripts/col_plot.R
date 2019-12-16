library(dplyr)
library(plotly)
library(ggplot2)

player_data <- read.csv("../data/Player_Stats.csv", stringsAsFactors = FALSE)

shooting_data <- select(player_data, School, Conf, Totals.FGA, Totals.FG)

school_shooting_data <- shooting_data %>%
  filter(Conf == "Pac-12") %>%
  group_by(School) %>%
  summarise(FGA = sum(Totals.FGA), FG = sum(Totals.FG))

school_shooting_data$FG_Missed <- school_shooting_data$FGA - school_shooting_data$FG

to_plot <- tibble(
  School = "",
  FG_FGM = "",
  Num = 0
)



for (school in school_shooting_data$School) {
  fg <- school_shooting_data %>%
    filter(School == school) %>%
    pull(FG)
  
  
  fgm <- school_shooting_data %>%
    filter(School == school) %>%
    pull(FG_Missed)
  
  to_plot <- add_row(to_plot, School = school, FG_FGM = "FG Made", Num = fg)
  to_plot <- add_row(to_plot, School = school, FG_FGM = "FG Missed", Num = fgm)
  to_plot <- add_row(to_plot, School = school, FG_FGM = "Total", Num = fg + fgm)
}

to_plot <- to_plot[-c(1), ]

col_plot <- ggplot(to_plot, aes(School, Num, fill = FG_FGM)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

get_col_plot <- function() {
  return(ggplotly(col_plot))
}
