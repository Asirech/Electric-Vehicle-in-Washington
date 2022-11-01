
shinyServer(function(input, output){ 
  
  output$plot_bar <- renderPlotly({
    
    County <- 
      df %>% 
      #filter(City == input$select_City) %>% 
      group_by(Make,County) %>% 
      summarise(Total_E_Vehicle = n()) %>% 
      arrange(desc(Total_E_Vehicle)) %>% 
      top_n(10)
    
    County <-  
      County %>%
      mutate(label = glue("County : {County},
                        Unit : {Total_E_Vehicle},
                        Make : {Make}"
      ))
    
    plot1 <-  ggplot(data = County, 
                     mapping = aes(x = Total_E_Vehicle , 
                                   y = reorder(County, Total_E_Vehicle ),
                                   text = label)) + 
      geom_col(aes(fill = Total_E_Vehicle ), show.legend = T) +
      scale_color_gradient(low = "red", high = "black") +
      labs(
        title = "Electric Vehicle in Washingston Base on County",
        y = "",
        x = "Total Vehicle"
      ) +
      theme_minimal()
    ggplotly(plot1,tooltip = "text")
    
    
  })
  
  #output$out_range <- (input$range)
  # 
  output$plot_scatterplot <- renderPlotly({
    
    year_start <- input$Year[1]
    year_end <- input$Year[2]
    
    Make_Year <-
      df %>%
      filter(Year >= year_start & Year <= year_end) %>%
      group_by(Make) %>%
      summarise(median_range = median(Electric.Range))


    Make_Year <-
      Make_Year %>%
      mutate(label = glue("median range : {median_range}
                          "
      ))

    plot2 <- ggplot(data = Make_Year,
                    mapping = aes(x = Make,
                                  y = median_range,
                                  text = label)) +
      geom_jitter(aes(size = median_range), col = "brown", alpha = 0.7) +
      labs(title = glue("Average Range of Electric Vehicle"),
           x = "Year",
           y = "Median Range") +
      theme_minimal()
 
    ggplotly(plot2,tooltip = "text")


  })
  
  
  
  output$plot_hist <- renderPlotly({
    
    range_year <- 
      df %>% 
      filter(Model.Year == input$yearbetween) %>%
      group_by(Make) %>% 
      summarise(total = n())
    
    range_year <- 
      range_year %>% 
      mutate (label = glue("Total : {total}"))
    
    plot3 <- 
      ggplot(data = range_year, 
             mapping = aes(x= Make,
                           y= total,
                           text = label)) +
      geom_col(aes(fill = total ),col = "brown",fill = "brown", show.legend = T) +
      labs(
        title = glue("Total Vehicle by Brand"),
        y = "Total",
        x = "Make") +
      theme_minimal()
    
    #ggplotly
    ggplotly(plot3, tooltip = "text")
      
    
  })
  
  output$detaildata <-  DT::renderDataTable({

    detaildata <- df[,c("County","City","Model.Year","Make","Model","Electric.Vehicle.Type","Electric.Range")]
    
    DT::datatable(detaildata,
                  filter="top",
                  selection="multiple",
                  escape = FALSE,
                  options = list(dom = 'ltipr',
                                 scrollX=T))

  })
  
  })
  
  
  

 