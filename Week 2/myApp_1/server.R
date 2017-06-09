#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plot1 <- renderPlot({
#        set.seed(12345)
        num_gen <- input$numeric
        xmin <- input$sliderX[1]
        xmax <- input$sliderX[2]
        ymin <- input$sliderY[1]
        ymax <- input$sliderY[2]
        DataX <- runif(num_gen,min = xmin,max = xmax)
        DataY <- runif(num_gen,min = ymin,max = ymax)
        xlab <- ifelse(input$show_xlab,"X Axis","")
        ylab <- ifelse(input$show_ylab,"Y Axis","")
        title <- ifelse(input$show_title,input$title_text,"")

        plot(DataX,DataY,xlab = xlab,ylab = ylab,main = title,
             xlim = c(xmin,xmax),ylim = c(ymin,ymax))

  })
  
})
