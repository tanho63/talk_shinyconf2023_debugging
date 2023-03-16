library(shiny)
library(DT)
library(tidyverse)

ui <- fluidPage(
  selectInput("car", 
              "Select car",
              choices = rownames(mtcars)
              ),
  DTOutput("my_car")
)

server <- function(input, output, session) {
  my_car <- reactive({
    mtcars |> 
      rownames_to_column("car") |> 
      filter(car %in% input$car)
  })
  
  output$my_car <- renderDT({
    my_car |> 
      select(car, cyl, hp, mpg)
  })
}

shinyApp(ui, server)
