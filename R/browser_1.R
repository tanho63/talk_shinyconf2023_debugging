library(shiny)
library(DT)
library(tidyverse)

ui <- fluidPage(
  DTOutput("my_table")
)

server <- function(input, output, session) {
  output$my_table <- renderDT({
    df_mtcars <- mtcars |> 
      rownames_to_column("car")
    
    browser()
    
    df_mtcars |> 
      select(car, mpg, cyl) |> 
      datatable()
  })
}

shinyApp(ui, server)