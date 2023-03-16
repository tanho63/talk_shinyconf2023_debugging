library(shiny)
library(tidyverse)
library(DT)

ui <- fluidPage(
  fluidRow(
    textInput("username", "Username"),
    textInput("password", "Password"),
    textInput("league_id", "League ID")
  ),
  fluidRow(actionButton("run","PREDICT THE FUTURE PLS")),
  fluidRow(
    DTOutput("crystal_ball")
  )
)

server <- function(input, output, session) {
  rv <- reactiveValues()
  
  observeEvent(input$run,{
    rv$auth <- api_login(input$username,  input$password, input$league_id)
    rv$standings <- download_standings(rv$auth)
    rv$schedule <- download_schedule(rv$auth)
    rv$projections <- calculate_projected_wins(rv$standings,  rv$schedule)
  })
  
  output$crystal_ball <- renderDT(rv$projections)
}

shinyApp(ui, server)
