
library("shiny")
library("ggplot2")
library("tidyverse")

# Make a toy dataset

x <- c(1,2,3,4,5)
y <- c(52,49,19,15,31)
grouping1 <- as.factor(c(1,1,1,2,2))
grouping2 <- as.factor(c(1,2,3,4,5))
toydataset <- data.frame(x,y,grouping1,grouping2)

# Make palettes to apply to each grouping

palette1 <- c("blue","red")  
palette2 <- c("orange","yellow","green","blue","purple")

# the UI bit:
ui <- fluidPage(
    titlePanel("My question"),
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "selectedvariable",
                        label = "Select a variable", 
                        choices = c("grouping1","grouping2")),
        ),
        mainPanel(
            plotOutput("myplot")
        )
    )
)

# the server bit:
server <- function(input, output) {
    
    currentpalette <- reactive({
        if (is.numeric(estate)){palette1}
        else if (input$selectedvariable == "grouping2"){palette2}
    })
    output$myplot <- renderPlot({
        ggplot() +
            geom_point(data = toydataset,
                       aes_string(x = "x", y = "y", color = input$selectedvariable)) +
            scale_color_manual(values = currentpalette())
    })
}

# Run it 
shinyApp(ui = ui, server = server)