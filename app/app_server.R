df <- read.csv("data/Player_Stats.csv", stringsAsFactors = FALSE)

pie_df <- df
pie_df$FT_Pts <- df$Totals.FT
pie_df$FG_Pts <- df$Totals.FG * 2
pie_df$Three_Pts <- df$Totals.3P * 3
pie_df$Total_Pts <- df$Totals.PTS
pie_df <- select(pie_df, Conf, Pos, FT_Pts, FG_Pts, Three_Pts, Total_Pts)

get_pie_df <- function(input) {
  new_pie_df <- pie_df %>%
    filter(Conf == input$selected_conf) %>%
    group_by(Pos) %>%
    summarise(FT_Pts = mean(FT_Pts), FG_Pts = mean(FG_Pts), 
              Three_Pts = mean(Three_Pts), Total_Pts = mean(Total_Pts))
  
  return(new_pie_df)
}

get_pos_vect <- function(input) {
  pos_vect <- get_pie_df(input) %>%
    pull(Pos)
  
  return(pos_vect)
  
}


player_table_function <- function(name){
  return_data_frame <- df %>%
    filter(Player == name) 
  
}





jitter_df <- df 
get_jitter_df <- function(input) {
  ##jitter_df$STL_BLK <- jitter_df$Totals.STL + jitter_df$Totals.BLK
  
  jitter_df <- jitter_df %>% 
    filter(Conf == input$selected_conf_2)
  
  jitter_df$Blocks_Steals <- jitter_df$Totals.STL + jitter_df$Totals.BLK
  jitter_df$Personal_Fouls <- jitter_df$Totals.PF  
  jitter_df$hover <- paste("Player Name: ", jitter_df$Player, sep = "")
  
    return(jitter_df)
}

get_col_df <- function(input) {
  shooting_data <- select(df, School, Conf, Totals.FGA, Totals.FG)
  
  school_shooting_data <- shooting_data %>%
    filter(Conf == input$selected_conf_3) %>%
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
  return(to_plot)
}

server <- function(input, output){
  output$matisse_img <- renderImage({
    outfile <- "../imgs/matisse_dunk.jpg"
    
    # Generate the PNG
    png(outfile, width = 400, height = 300)
    
    dev.off()
    
    # Return a list containing the filename
    list(src = outfile,
         contentType = 'image/png',
         width = 400,
         height = 300,
         alt = "This is alternate text")
  }, deleteFile = FALSE)
  
  
  output$pie_plot <- renderPlotly(
    plot_ly(get_pie_df(input), labels = get_pos_vect(input), 
            values = pull(get_pie_df(input), input$pt_type),
            type = 'pie') %>%
      layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             width = 600)
  )

  output$player_table1 <- renderTable({
     partone <- player_table_function(input$player_name)
     partone[1:8]
    })
  output$player_table2 <- renderTable({
    parttwo <- player_table_function(input$player_name)
    parttwo[9:17]
  })
  output$player_table3 <- renderTable({
    partthree <- player_table_function(input$player_name)
    partthree[18:26]
  })


  output$jitter_plot <- renderPlotly(
    ggplotly(
      ggplot(get_jitter_df(input), aes(Blocks_Steals, Personal_Fouls, text = hover)) +
      labs(title =" Steals & Blocks vs Total Personal Fouls by School", x = "Steals or Blocks", 
           y = "Personal Fouls")+
      geom_jitter(aes(color = School)) 
    )
  )
  
  output$col_plot <- renderPlotly(
    ggplotly(
    ggplot(get_col_df(input), 
           aes(School, Num, fill = FG_FGM)) +
      geom_bar(stat = "identity", position = "dodge") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    )
  )
}



