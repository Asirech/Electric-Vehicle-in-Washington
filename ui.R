dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "Electric Vehicle Analysis",titleWidth = 1200),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Main Dasboard",
        tabName = "tab_maindashboard",
        icon = icon("gauge")
      ),
      menuItem("Vehicle Range",
        tabName = "tab_vehiclerange",
        icon = icon("fa-duotone fa-route")
      ),
      menuItem("Brand",
        tabName = "tab_Brand",
        icon = icon("diamond")
      ),
      menuItem("Data",
               tabName = "tab_data",
               icon = icon("table")
      )
    )
  ),
  dashboardBody(
    tabItems(
      # PAGE 1
      tabItem(
        tabName = "tab_maindashboard",
        fluidRow(
          infoBox("TOTAL COUNTY",
            length(unique(df$County)),
            icon = icon("fa-duotone fa-earth-americas"),
            color = "blue",
            fill = T,
          ),
          infoBox("TOTAL CITY",
            length(unique(df$City)),
            icon = icon("city"),
            color = "red",
            fill = T,
          ),
          infoBox("TOTAL BRAND",
            length(unique(df$Make)),
            icon = icon("flag"),
            color = "green",
            fill = T,
          )
        ),

        # ROW 3 -> plot1
        fluidRow(
          box(
            width = 12,
            plotlyOutput(outputId = "plot_bar")
          )
        )
      ),
      # PAGE 2
      tabItem(tabName = "tab_vehiclerange", 
              fluidRow(
                box(
                  background = "olive",
                  br(),
                  sliderInput("Year",
                              "Select Range:",
                              min = 1997,
                              max = 2023,
                              value = c(1997,max(2023)),
                              step= 1,
                              round = TRUE,
                              tick = FALSE
                              
                  )),
                                    
                  ),
                  
                  box(width = 12,
                      plotlyOutput(outputId = "plot_scatterplot"))

                ),
      
      # PAGE 3
      tabItem(tabName = "tab_Brand", 
              fluidRow(
                box(
                  width = 12,
                  selectInput(
                    inputId = "yearbetween",
                    label = "Choose Year",
                    choices = sort(unique(df$Model.Year)),
                    selected = "2019"
                  ),
                  
                  box(width = 12,
                      plotlyOutput(outputId = "plot_hist"))
                  
                )
              )
              
      ),
      
      #PAGE 4
      tabItem(tabName = "tab_data",
              markdown(
                "
                # DATA SET ELECTRIC VEHICLE POPULATION
                source : <https://catalog.data.gov/dataset/electric-vehicle-population-data>
                
                + Resource Type :	Dataset
                + Metadata Created Date	: November 10, 2020
                + Metadata Updated Date : October 21, 2022
                + Publisher :	data.wa.gov
                + Unique Identifier :	Unknown
                + Maintainer : Department of Licensing
                "
              ),
              fluidRow(
                box(
                  width = 12,
                  DT::dataTableOutput("detaildata"))
              )
      )
  
      
              ),
       

              
              ),
      
      

    )
  
