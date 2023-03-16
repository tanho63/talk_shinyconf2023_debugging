library(shiny)

ui <- fluidPage(
  textInput("package",
            "What's your favourite package?"),
  textOutput("fav_pkg")
)

server <- function(input, output, session) {
  output$fav_pkg <- renderText(input$package))
}

shinyApp(ui, server)