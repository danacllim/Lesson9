library(shiny)
library(lubridate)
data <- read.csv("Superstore_Orders.csv")
select_str <- c("Order.Date", "Sales", "Region", "Product.Category")
data <- data[select_str]
data$Order.Date <- as.Date(data$Order.Date, format = "%d-%m-%y")
data$month <- month(data$Order.Date)
data$year <- year(data$Order.Date)

shinyServer(function(input, output) {

  output$plot <- renderPlot({
    
    plotdata <- aggregate(formula = Sales ~ month + year, data = data, FUN = sum, subset = (Region == input$Region 
                          & (Product.Category == input$Product)))
    
    max_y <- max(plotdata$Sales)*1.3

    with(subset(plotdata, year == 2009), plot(month, Sales, col = "green", type = "l", ylab = "Sales", xlab = "Month", xlim = c(0,12), ylim = c(0, max_y)))
    with(subset(plotdata, year == 2010), lines(month, Sales, col = "red"))
    with(subset(plotdata, year == 2011), lines(month, Sales, col = "blue"))
    with(subset(plotdata, year == 2012), lines(month, Sales, col = "black"))
    legend("top", lty = c(1,1,1,1), 
           col = c("green", "red", "blue", "black"), 
           legend = c("2009","2010", "2011","2012"),
           ncol = 4)

  })

})
