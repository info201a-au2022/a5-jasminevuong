# Loading packages 
library("tidyverse")
library("shiny")
library("plotly")
library("data.table")
library("shinythemes")
library("rsconnect")

# Loading data
co2_data <- fread("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Relevant Values of Interest

# The year with the highest levels of CO2
year_highest <- co2_data %>% 
  filter(co2 == max(co2, na.rm = TRUE))%>%
  pull(year)

# The average yearly production of CO2 in million tonnes in the year 1921
year_1921_average <- co2_data %>% 
  filter(year == "1921") %>% 
  summarize(mean(co2, na.rm = TRUE)) %>% 
  pull()

# The average yearly production of CO2 in million tonnes in the year 2021
year_2021_average <- co2_data %>% 
  filter(year == "2021") %>% 
  summarize(mean(co2, na.rm = TRUE)) %>% 
  pull()

# server Function
server <- function(input, output) {
  
  co2_1 <- reactive({
    req(input$co2_sel)
    
    co2_2 <- co2_data %>% 
      filter(country %in% input$sel_country) %>%
      group_by(year, country) %>% 
      summarize(co2, 
                co2_per_capita, 
                consumption_co2, 
                consumption_co2_per_capita, 
                year, 
                country)
  })
  
  output$co2_plot <- renderPlotly({
    co2_graph <- ggplot(co2_1(), aes(x = year, y = ,input$co2_sel)) + 
      geom_line() +
      ggtitle(paste("CO2 Trends in", input$sel_country)) +
      xlab("Year") +
      ylab("Total")
    ggplotly(co2_graph)
  })
  
}