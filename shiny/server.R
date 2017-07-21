library(shiny)

shinyServer(function(input, output) {
  
  output$graf <- renderPlot({
    data <- filter(prodaja, 
                   Country == input$drzava, Type == input$tip)
    
    g <- ggplot(data = data, aes(x = factor(Year), y = Number/1e6)) + geom_bar(stat="identity", position="dodge",fill ="cornflowerblue")
    g <- g + xlab("Leto") + ylab("Število prodanih avtomobilov") 
    
    g
  })
  
  output$graf1 <- renderPlot({
    data <- filter(proizvodnja, 
                   Country == input$drzava1, Type == input$tip1)
    
    g1 <- ggplot(data = data, aes(x = factor(Year), y = Number/1e6)) + geom_bar(stat="identity", position="dodge",fill ="cornflowerblue")
    g1 <- g1 + xlab("Leto") + ylab("Število proizvedenih avtomobilov") 
    
    g1
  })
  
  output$graf2 <- renderPlot({
    data <- filter(uporaba, 
                   Country == input$drzava2, Type == input$tip2)
    
    g2 <- ggplot(data = data, aes(x = factor(Year), y = Number/1e6)) + geom_bar(stat="identity", position="dodge",fill ="cornflowerblue")
    g2 <- g2 + xlab("Leto") + ylab("Število avtomobilov v uporabi") 
    
    g2
  })
})