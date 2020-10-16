# Yunting Chiu

library(shiny)

# named the type of plot first
plotTypes <- c("Density Plot", "Histogram", "Frequency Polygon")

# Inputting to three different variables
ui <- fluidPage(
    
    varSelectInput("x", label = "X variable",
                   data = mtcars, selected = "mpg"),
    radioButtons(inputId = "plotType", label = "Choose a plot type",
                 choices = plotTypes),
    plotOutput("plot")
)

# Define server logic required to draw a scatterrplot
server <- function(input, output) {
    output$plot <- renderPlot({
        ggplot(mpg, aes(x = !!input$x, y = !!input$y)) +
            geom_point(aes(color = !!input$color)) +
            theme_bw()
    })
    
}
# Run the application 
shinyApp(ui = ui, server = server)
