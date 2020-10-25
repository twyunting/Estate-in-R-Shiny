library(shiny)
library(lmtest)
library(ggplot2)
library(broom)

ui <- navbarPage(tabPanel("Predictions",
                          tabsetPanel(
                              tabPanel("Linear Regression", 
                                       tags$h1("Predicting G3 using G1 as predictor using Linear Regression"), 
                                       verbatimTextOutput("ML"),
                                       plotOutput("Model")
                              ))
))

server <- shinyServer(function(input, output) {
    model <- lm(formula = wt ~ hp, data = mtcars)
    
    output$ML <- renderPrint({
        summary(model)
    })
    
    output$Model <- renderPlot({
        tmp <- augment(model)
        ggplot(tmp, aes(x = .fitted, y = .resid)) +
            geom_point() +
            geom_smooth(method = loess, formula = y ~ x) 
    })
})


shinyApp(ui = ui, server = server)