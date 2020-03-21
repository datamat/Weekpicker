#install.packages("shinydashboard")

library(shiny)
library(shinydashboard)
library(shinyjs)

options(shiny.testmode=TRUE)

dateInputCustom <- function(inputId,label,startDate=NULL,...) {
  picker <- shiny::dateInput(inputId,label,format="yyyy-mm-dd",...)
  picker$children[[2L]]$attribs[["data-date-start-date"]] <- startDate
  picker$children[[2L]]$attribs[["data-date-calendar-weeks"]] <- "true"
  picker$children[[2L]]$attribs[["data-date-today-highlight"]] <- "true"
  picker
}

InitialDate <- Sys.Date()

ui <- dashboardPage(
  skin="green",
  dashboardHeader(title="Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
    includeCSS("www/style.css"),
    fluidRow(
      box(title="Week Picker",
          dateInputCustom("picker","",
                          value = as.Date(InitialDate),
                          startDate = "2012-01-01",
                          weekstart = 1)),
      box(title="Date chosen",textOutput("date")))
  )
)

server <- function(input, output, session) {
  output$date <- renderText({
    zz <- format(input$picker,"%V")
    paste("Chosen week number is", as.character(zz))
  })
}

shinyApp(ui, server)