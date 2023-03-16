library(shiny)
library(tidyverse)

ui <- fluidPage(
  fluidRow(
    
  textInput("username", "Username"),
  textInput("password", "Password"),
  textInput("league_id", "League ID")
  )
)

server <- function(input, output, session) {
  my_cars <- reactive({
    mtcars |> 
      rownames_to_column("car") |> 
      filter(car %in% input$car)
  })
  
  output$average_mpg <- renderText({
    paste("The average mpg of my cars is",
          mean(my_cars$mpg))
  })
}

shinyApp(ui, server)
