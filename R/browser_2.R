library(shiny)
library(DT)
library(tidyverse)

ui <- fluidPage(
  actionButton("debug","debug"),
  selectInput("car", 
              "Select car",
              choices = rownames(mtcars)
  ),
  DTOutput("my_car")
)

server <- function(input, output, session) {
  observeEvent(input$debug, browser())
  
  my_car <- reactive({
    mtcars |> 
      rownames_to_column("car") |> 
      filter(cyl %in% input$car)
  })
  
  output$my_car <- renderDT({
    my_car() |> 
      select(car, cyl, hp, mpg)
  })
}

shinyApp(ui, server)