library(shiny)
library(leaflet)

source('helper.R')

cities_and_dates <- c("munich", "madrid","amsterdam","berlin","antwerp")
feature_list <- c("id", "neighbourhood_cleansed", 
                  "property_type", "room_type", "accommodates", "bedrooms", 
                  "beds", "price", "availability_30", "minimum_nights",  "maximum_nights","estimated_revenue_30")
plot_list <- c("bar","hist")


ui <- fluidPage(
    titlePanel("Mini Project"),
                 tabsetPanel(
                     tabPanel("Analysis 1", 
                              titlePanel("Analysis 1 – Comparing cities"),
                              sidebarLayout(
                                  sidebarPanel(
                                      selectInput("city_compare2", "Select city from list",
                                                  choices = cities_and_dates,selected = "amsterdam"),
                                      radioButtons("date_a1_city2", label = ("Select The dataset from last 3 available"),
                                                   inline = TRUE,
                                                   choices = list("Most Recent" = 1, "2nd Recent" = 2, "3rd Recent" = 3), 
                                                   selected = 1),
                                      selectInput("city_compare1", "Select city from list",
                                                  choices = cities_and_dates,selected = "munich"),
                                      radioButtons("date_a1_city1", label = ("Select The dataset from last 3 available"),
                                                   inline = TRUE,
                                                   choices = list("Most Recent" = 1, "2nd Recent" = 2, "3rd Recent" = 3), 
                                                   selected = 1),
                                      selectInput("feature_select","Select the feature you want to cover",
                                                  choices = feature_list,selected = "price")
                                  ),
                                  mainPanel(
                                      radioButtons("plot_select_a1", label = ("Select The Plot type"),
                                                   inline = TRUE,
                                                   choices = list("box" = "box","jitter"="jitter", "bar" = "bar"), 
                                                   selected = "box"),
                                      uiOutput("selections"),
                                      plotOutput("analysis1",width = "100%")
                                  )
                              )),
                     
                     # Analysis 2 Deep Analysis
                     tabPanel("Analysis 2 - Part 1", 
                              titlePanel("Analysis 2 – Deep dive into a city"),
                              sidebarLayout(
                                  sidebarPanel(
                                      selectInput("city_select2", "Select city from list",
                                                  choices = cities_and_dates,selected = "munich"),
                                      radioButtons("date_select2", label = h3("Select The dataset from last 3 available"),
                                                   choices = list("Most Recent" = 1, "2nd Recent" = 2, "3rd Recent" = 3), 
                                                   selected = 1),
                                      selectInput("feature_select_a2","Select the feature you want to cover",
                                                  choices = list("price","room_type","bedrooms","availability_30"),selected = "price")
                                  ),
                                  mainPanel(
                                      #radioButtons("plot_select_a2", label = ("Select The Plot type"),
                                      #             inline = TRUE,
                                      #             choices = list("box" = "box","jitter"="jitter", "bar" = "bar"), 
                                      #             selected = "box"),
                                      plotOutput("analysis2")
                                  )
                                  
                              )),
                     
                     
                     # Analysis 2 Map
                     tabPanel("Analysis 2 - Part 2", 
                              titlePanel("Analysis 2 – Deep dive into a city - Maps"),
                              sidebarLayout(
                                  sidebarPanel(
                                      selectInput("city_select", "Select city from list",
                                                  choices = cities_and_dates,selected = "munich"),
                                      radioButtons("date_select", label = h3("Select The dataset from last 3 available"),
                                                   choices = list("Most Recent" = 1, "2nd Recent" = 2, "3rd Recent" = 3),
                                                   selected = 1)
                                  ),
                                  mainPanel(
                                      uiOutput("selections_map"),
                                      leafletOutput("mymap")
                                  )
                              ))
                     
                 )
        )
    


# Define server logic required to draw a histogram
server <- function(input, output) {
    #display selection
    output$selections <- renderUI(
        paste("Your city selection is",
              input$city_compare1,"in date", 
              find_data_dates(input$city_compare1,input$date_a1_city1),
              "and",input$city_compare2,"in date",
              find_data_dates(input$city_compare2,input$date_a1_city2),
              input$feature_select,
              sep= " ")
    )
    
    output$selections_map <- renderUI(
        paste("Your city selection is",
              input$city_select,"in date", 
              find_data_dates(input$city_select,input$date_select),
              sep= " ")
        
    )
    
    
    # render the map by selected city and date (date recovered from database)
    output$mymap <- renderLeaflet({create_leaflet(input$city_select,
                                                  find_data_dates(input$city_select,input$date_select)) })
    
    
    #render plot for tab1
    output$analysis1 <- renderPlot(
        {analysis1(input$city_compare1,
                   input$city_compare2, 
                   find_data_dates(input$city_compare1,input$date_a1_city1), 
                   find_data_dates(input$city_compare2,input$date_a1_city2),
                   input$feature_select,
                   input$plot_select_a1
        )})
    
    #render plot for tab2
    output$analysis2 <- renderPlot(
        {analysis2(input$city_select2,
                   find_data_dates(input$city_select2,input$date_select2),
                   input$feature_select_a2
        )
        }
    )
    
}


# Run the application 
shinyApp(ui = ui, server = server)
