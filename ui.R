library(shiny)
data <- read.csv("Superstore_Orders.csv")
Region_list <- levels(data$Region)
product_list <-levels(data$Product.Category)

shinyUI(fluidPage(
  
  titlePanel("Sales Trends"),  # End of titlePanel
  
  sidebarPanel(
    
    h4("This application shows you yearly sales trend for 2009 - 2012"),
    p("Select your Region from the drop down list and select Products Category in the radio buttons below."), 
    p("The plot will show your Regional Sales over time."),

    
    # Dropdown List with Country
    selectInput(inputId = "Region",  
                label = "Select Region:",  
                choices = Region_list,  
                selected = Region_list[1]),
    
 
    
    # Radio Buttons to select product
    radioButtons(inputId = "Product", label = "Select Product Category",
                 choices = product_list, 
                 selected = product_list[1])
    
    
  ), # End of sidebarPanel
  
  mainPanel(
  

    # Plot Headcount trend
    
    plotOutput(outputId = "plot", height = "450px")
  
  ) # End of mainPanel
  
))
