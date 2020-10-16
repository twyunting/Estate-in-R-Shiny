#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
mpg %>% select_if(is.character)  -> mpgChr
ui <- fluidPage(
     
    varSelectInput("x", label = "X variable", data = mpg),
    varSelectInput("y", label = "Y variable", data = mpg),
    varSelectInput("colorb", label = "Color variable (categorical)",  mpgChr),
    plotOutput("plot")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$plot <- renderPlot({
        ggplot(mpg, aes(x = !!input$x, y = !!input$y)) +
            geom_point(aes(color = !!input$colorb))
    })
   
}

# Run the application 
shinyApp(ui = ui, server = server)
