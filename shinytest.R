library(shiny)

ui <- fluidPage(
  sliderInput(inpitId ="num", label ="Izberi stevilo",
              value = 25, min = 1, max = 100),
  plotOutput("hist")
)

server <- function(input, output) {}

shinyApp(ui=ui, server = server)