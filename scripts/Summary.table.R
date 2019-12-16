library(dplyr)

get_summary_table <- function(path) {
NCAA_df <- read.csv(path, stringsAsFactors = FALSE)
NCAA_df <- select(NCAA_df, School, Conf, Totals.PTS, Totals.FGA, Totals.3P, MP, Totals.TRB, Totals.AST)

NCAA_df <- NCAA_df %>%
  filter(Conf == "Pac-12") %>%
  group_by(School) %>%
  filter(Conf == "Pac-12") %>%
  summarise(pts_mean = mean(NCAA_df$Totals.PTS, na.rm = TRUE),
            three_mean = mean(NCAA_df$Totals.3P, na.rm = TRUE),
            mp_mean = mean(NCAA_df$MP, na.rm = TRUE),
            trb_mean = mean(NCAA_df$Totals.TRB, na.rm = TRUE),
            ast_mean = mean(NCAA_df$Totals.AST, na.rm = TRUE))

NCAA_df <- select(NCAA_df, pts_mean, three_mean, mp_mean, trb_mean, ast_mean)

NCAA_df <- NCAA_df %>%
  summarise(pts_mean = mean(NCAA_df$pts_mean, na.rm = TRUE),
            three_mean = mean(NCAA_df$three_mean, na.rm = TRUE),
            mp_mean = mean(NCAA_df$mp_mean, na.rm = TRUE),
            trb_mean = mean(NCAA_df$trb_mean, na.rm = TRUE),
            ast_mean = mean(NCAA_df$ast_mean, na.rm = TRUE))

colnames(NCAA_df) <- c("Average Points", "Average Threes Made", "Average Minutes Played", 
                    "Average Total Rebounds", "Average Assists")

return(NCAA_df)
}
