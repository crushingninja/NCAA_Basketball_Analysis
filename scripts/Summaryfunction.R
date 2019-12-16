NCAA_df <- read.csv("data/Player_Stats.csv", stringsAsFactors = FALSE)
NCAA_df <- NCAA_df %>%
  filter(Conf == "Pac-12")

get_summary_info <- function(){
  summary <- list()
  Pts_mean <- mean(NCAA_df$Totals.PTS, na.rm = TRUE)
  Three_mean <- mean(NCAA_df$Totals.3P, na.rm = TRUE)
  MP_mean <- mean(NCAA_df$MP, na.rm = TRUE)
  TRB_mean <- mean(NCAA_df$Totals.TRB, na.rm = TRUE)
  AST_mean <- mean(NCAA_df$Totals.AST, na.rm = TRUE)
  summary <- list(Pts_mean, Three_mean, MP_mean, TRB_mean, AST_mean)
  return(summary)
}
