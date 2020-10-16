# Yunting Chiu


library(shiny)

# Define UI for application that draws a histogram

ui <- fluidPage(

    # Application title
    # titlePanel("Old Faithful Geyser Data"),
    
    varSelectInput("cty", label = "X variable", data = mpg)
    varSelectInput("hwy", label = "Y variable", data = mpg)
) 


# Define server logic required to draw a histogram
server <- function(input, output) {

  
}

# Run the application 
shinyApp(ui = ui, server = server)
