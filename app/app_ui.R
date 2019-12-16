library(shiny)
page_one <- tabPanel(

  h3("About"),
  column(
    11,
    align = "center",
    offest = 1,
  h1("NCAA 2017-2018 College Basketball Statistics"),
  h5("Our Ideology"),
  h4("Our main objective in this project was to identify general school and player
     statistics within the NCAA Men's basketball league."),
  h4("The data we used was sourced from an Excel spreadsheet containing player statistics
     from the 2017-2018 season. This file had player information including their school, conference, 
     field goal attempts, field goals made, and other statistics relevant to basketball."),
  img("", src = "https://media.giphy.com/media/3oz8xUgF5WLTV3RjFu/giphy.gif", 
      width = 800),

  p(" "),
  h5("Our Main Questions"),
  h4("  Statistics is ubiquitious especially when referred to the exciting world of sports"),
  h4("and athletics. Because of this phenomenon, questions arise from either interest or "),
  h4("from analytics. We wanted to tackle these curiosities, some of which consider the"),
  h4("distribution of various points made by players of different positions within different"),
  h4("conferences. Also, try uncover trends within the ratios of defensive statistics and,"),
  h4("hope to unearth the effciency of offense based on the school within their respective"), 
  h4("conference.")
  )
)

df <- read.csv("data/Player_Stats.csv", stringsAsFactors = FALSE)

conferences <- df %>%
  select(Conf) %>%
  distinct()


page_two <- tabPanel(
  h3("Pts by Position"),
  column(
    width = 11,
    align = "center",
    h1("Scoring Distribution by Player Position"),
  ),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "selected_conf",
        label = "Conference",
        choices = conferences[,1]
      ),
      selectInput(
        inputId = "pt_type",
        label = "Point Type",
        choices = list("Free Throw Points" = "FT_Pts", "Field Goal Points" = "FG_Pts",
                       "Three Point Shots" = "Three_Pts", "Total Points" = "Total_Pts")
      ),
      h4("Position Key:"),
      p("   G: Guard"),
      p("   F: Forward"),
      p("   C: Center"),
      p("   SF: Small Forward"),
      p("   PF: Power Forward"),
      p("   PG: Point Guard"),
      p("   SG: Shooting Guard")
    ),
    mainPanel(
      h4("Avg Points by Conf, Player Position, and Point Type"),
      plotlyOutput(outputId = "pie_plot")
    )
  )
)


page_three <- tabPanel(
  h3("Defensive Efficiency"),
  column(
    width = 11,
    align = "center",
    h1("Defensive Efficiency of Players by School"),
  ),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "selected_conf_2",
        label = "Conference",
        choices = conferences[,1]
      )
    ),
    mainPanel(
      h3("Total Blocks and Steals, vs Personal Foul"),
      plotlyOutput("jitter_plot") 
      
    )
  )
)

page_four <- tabPanel(
  h3("Offensive Efficiency"),
  column(
    width = 11,
    align = "center",
    h1("Offensive Efficiency by School")
  ),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "selected_conf_3",
        label = "Conference",
        choices = conferences[,1]
      )
    ),
  
    mainPanel(
      h4("Total Field Goals, Field Goals Made, & Field Goals Missed by School"),
      plotlyOutput(outputId = "col_plot")
    )
  )
  
)

page_five <- tabPanel(
  h3("Reflections"),
  h4(em("Point Distribution:"), "Relative even scoring distribution across all positions and all 
     point types with the exception of three pointers which is skewed heavily towards guards."),
  h4(em("Defensive Efficiency:"), "As the amount of blocks and steals a player has increase,
    so does their amount of personal fouls. The two values are positively correlated."),
  h4(em("Offensive Efficiency:"), "Across all confrences, the team that shot the most did not always lead their 
     conference in field goals made. Some teams shot the ball less, yet making more baskets than others. This indicates a high
     field goal percentage.")
)


page_six <- tabPanel (
  h3("Player Stats"),
  h1("Search A Player"),
    mainPanel(
      textInput(
        inputId = "player_name",
        label = "Search Player's Name",
      ),
      em(p("(Type in player name. eg. David Crisp)")),
      tableOutput(outputId = "player_table1"),
      tableOutput(outputId = "player_table2"),
      tableOutput(outputId = "player_table3")
    )
)
ui <- navbarPage(
  "Final",
  page_one,
  page_six,
  page_two,
  page_three,
  page_four,
  page_five
)

ui <- fluidPage(
  includeCSS("css/styles.css"),
  navbarPage(
    h2("NCAA 2017-2018"),
    page_one,
    page_two,
    page_three,
    page_four,
    page_six,
    page_five
  )
)

