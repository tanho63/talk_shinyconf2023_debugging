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
  
  output$my_car <- renderDT({
    
    df_mtcars <- mtcars |> 
      rownames_to_column("car") |> 
      filter(car %in% input$car)
    
    browser()
    
    df_mtcars |> 
      select(car, hp, mpg, cyl) |> 
      datatable()
  })
}

shinyApp(ui, server)