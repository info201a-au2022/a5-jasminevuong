
########################
#### A5 App Server  ####
########################

# Loading packages 
library("tidyverse")
library("shiny")
library("plotly")
library("data.table")
library("shinythemes")

# Loading data
co2_data <- fread("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

#####################################
#### Relevant Values of Interest ####
#####################################

# The year with the highest levels of CO2
year_highest <- co2_data %>% 
  filter(co2 == max(co2, na.rm = TRUE))%>%
  pull(year)

# The average yearly production of CO2 in million tonnes in the year 1921
year_1921_average <- co2_data %>% 
  filter(year == "1921") %>% 
  summarize(round(mean(co2, na.rm = TRUE), digits = 2)) %>% 
  pull()

# The average yearly production of CO2 in million tonnes in the year 2021
year_2021_average <- co2_data %>% 
  filter(year == "2021") %>% 
  summarize(round(mean(co2, na.rm = TRUE), digits = 2)) %>% 
  pull()

#########################
#### Server Function ####
#########################

server <- function(input, output) {
  
  co2 <- reactive({
    req(input$co2_var)
    
    filtering_birth <- co2_data %>% 
      summarize(co2, 
                co2_per_capita, 
                consumption_co2, 
                consumption_co2_per_capita, 
                year, 
                country) %>%
      filter(country %in% input$sel_country) %>% 
      head(20)
  })
  
  output$co2_plot <- renderPlotly({
    co2_graph <- ggplot(co2(), aes(x = year, y = co2_data[,input$co2_var])) + 
      geom_bar(stat = "sum") +
      ggtitle(paste("Total", input$co2_var, "in", input$sel_country)) +
      xlab("Year") +
      ylab("Total")
    ggplotly(co2_graph)
  })
  
}