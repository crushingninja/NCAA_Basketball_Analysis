library(ggplot2)
library(dplyr)

#chart3 <- function(csv){
 ##
  #conf_pts_table <- data_frame %>%
   # group_by(Conf) %>%
    #summarize(total_conf_pts = sum(Totals.PTS))%>%
    #arrange(-total_conf_pts)
  
#  conf_pts_table$Conf <- factor(conf_pts_table$Conf, levels = conf_pts_table$Conf)
  
#  conf_pts_chart <- ggplot(data = conf_pts_table,
 #                          mapping = aes(x = Conf, y = total_conf_pts)) +
#    geom_violin() + 
 #   theme(axis.text = element_text(angle = 90, hjust = 1.05))
#}

#test <- chart3("data/Player_Stats.csv")
#print(test)


#data_frame <- read.csv("data/Player_Stats.csv", stringsAsFactors = FALSE)

#conf_pts_table <- data_frame %>%
 # group_by(Conf) %>%
  #summarize(total_conf_pts = sum(Totals.PTS))%>%
  #arrange(-total_conf_pts)

#conf_pts_table$Conf <- factor(conf_pts_table$Conf, levels = conf_pts_table$Conf)

#conf_pts_chart <- ggplot(data = conf_pts_table,
 #                        mapping = aes(x = Conf, y = total_conf_pts)) +
  #geom_bar(stat = "identity")



#print(conf_pts_chart)


#player_stats_data_frame <- read.csv("data/Player_Stats.csv", stringsAsFactors = FALSE)

#mp_tot_pts_table <- player_stats_data_frame %>%
  #group_by(Conf) %>%
  #summarize(minutes_played = sum(MP), total_points = sum(Totals.PTS))

#plot_mp_total_pts <- ggplot(data = mp_tot_pts_table) +
 # geom_dotplot(mapping = aes(x = minutes_played, y = total_points, color = Conf))
#print(plot_mp_total_pts)

pac_12_mp_total_pts <- function(csv){

  player_stats_df <- read.csv(csv, stringsAsFactors = FALSE)
  
  pac12_table <- player_stats_df %>%
  filter(Conf == "Pac-12")

  plot_mp_tot_pts <- ggplot(data = pac12_table, mapping = aes(x = MP)) +
  geom_point(aes(y = Totals.PTS, color = School, alpha = 0.1)) +
  labs(title = "PAC-12 Players: Points vs. Minutes Played", x = "Minutes Played", y = "Total Points")
  
  print(plot_mp_tot_pts)
}
