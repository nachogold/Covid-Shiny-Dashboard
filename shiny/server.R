function(input, output, session) {

  output$plot <- renderPlot({
    df_selection <- df[df$location %in% c(input$country_selection),]
    ggplot(data=df_selection)+
      geom_point(mapping = aes(x = date, y = eval(parse(text = input$graph_selection)), color=location))+
      xlab(label = "Date")+
      ylab(label = names(graph_options[graph_options==input$graph_selection]))+
      xlim(as.Date(input$dates[1]),as.Date(input$dates[2]))
  })
  
  output$Worldplot<-renderPlot({
    
    Combined$value <- mapData[[input$graph_selection]][match(Combined$region, mapData$location)]
    
    ggplot(Combined, aes(x=long, y=lat, group = group, fill = value)) + 
      geom_polygon(colour = "white") +
      scale_fill_continuous(low = "grey",
                            high = "red",
                            guide="colorbar") +
      theme_bw()  +
     labs(fill="reference" , x="", y="") +
      scale_y_continuous(breaks=c()) +
      scale_x_continuous(breaks=c()) +
      theme(panel.border =  element_blank())
  })
  
  output$wt <- renderText({
    paste0((names(graph_options[graph_options==input$graph_selection]))," on Date : ",(Sys.Date()-1))
  })
}
