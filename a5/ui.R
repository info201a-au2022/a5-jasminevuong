#ui function
ui <- fluidPage(theme = shinytheme("sandstone"),
                
                navbarPage(title = "Reconizing CO2 Trends",
                           tabPanel("Introduction", 
                                    
                                    h1("Introduction"),
                                    p("Climate change has been an ongoing issue for many decades 
                        and there has been a lack of improvement. The dataset from", 
                                      em("Our World In Data"), "demonstrates the CO2 emission trends from
                        1750 to 2021. By analyzing the data we can further understand 
                        and see how climate change has progressed due to CO2 emissions
                        over the years and bring awareness to the subject. In this 
                        report, I will be looking into the total production and 
                        consumption of CO2 in million tonnes, and total production and 
                        consumption of CO2 in tonnes per person. Additionally, we will
                        be looking into how these variables differ between each country
                        and have progressed over time. In 1921, the yearly average production of CO2 was", strong
                                      ("186.59 million tonnes"), "while in 2021, the yearly average production of CO2 emissions
                        was", strong("970.2 million tonnes"),". In the span of one hundred years, the
                        yearly average output more than quadrupled. Additionally, the year", strong("2021"),
                                      "was the one with the highest production of CO2 emissions. These
                        values show that climate change is not improving but drastically
                        worsening over the years and that we need to make a change to 
                        prevent further damage to our earth.")),
                           
                           
                           tabPanel("Data Visualization",
                                    h1("Data Visualization"),
                                    
                                    sidebarLayout(
                                      sidebarPanel(
                                        selectInput(inputId = "co2_sel",
                                                    label = "Select a CO2 varible:",
                                                    list("Total Production" = "co2",
                                                         "Total Production Per Person" = "co2_per_capita", 
                                                         "Total Consumtion" = "consumption_co2",
                                                         "Total Consumtion Per Person" = "consumption_co2_per_capita")),
                                        
                                        
                                        selectInput(inputId = "sel_country",
                                                    label = "Select a country:",
                                                    list("China",
                                                         "United States",
                                                         "Brazil",
                                                         "Russia",
                                                         "Nigeria",
                                                         "Australia"))),
                                      
                                      mainPanel(
                                        plotlyOutput(outputId = "co2_plot"),
                                        
                                        h3("Chart Description"),
                                        p("From this chart, you can select to change the varible to total production,
                                        production per person cosumtion, or consumtion per person to see the CO2 trend
                                        over the years. Additionally, you can select the specific country that you want
                                        to view.")
                                      )))))
