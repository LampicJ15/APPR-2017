library(shiny)

shinyServer(function(input, output) {
  
  output$graf <- renderPlot({
    data <- filter(prodaja, 
                   Country == input$drzava, Type == input$tip)
    
    g <- ggplot(data = data, aes(x = factor(Year), y = Number/1e3)) + geom_bar(stat="identity", position="dodge",fill ="cornflowerblue")
    g <- g + xlab("Leto") + ylab("Število prodanih avtomobilov (v tisočih) ") 
    
    g
  })
  
  output$graf1 <- renderPlot({
    data <- filter(proizvodnja, 
                   Country == input$drzava1, Type == input$tip1)
    
    g1 <- ggplot(data = data, aes(x = factor(Year), y = Number/1e3)) + geom_bar(stat="identity", position="dodge",fill ="cornflowerblue")
    g1 <- g1 + xlab("Leto") + ylab("Število proizvedenih avtomobilov (v tisočih)") 
    
    g1
  })
  
  output$graf2 <- renderPlot({
    data <- filter(uporaba, 
                   Country == input$drzava2, Type == input$tip2)
    
    g2 <- ggplot(data = data, aes(x = factor(Year), y = Number/1e3)) + geom_bar(stat="identity", position="dodge",fill ="cornflowerblue")
    g2 <- g2 + xlab("Leto") + ylab("Število avtomobilov v uporabi (v tisočih)") 
    
    g2
  })
  
  output$graf3 <- renderPlot({
    man <- proizvajalci%>% filter(Year == input$leto) #izberemo proizvajalce iz tega leta (manufacturers)
    man <- man[1:10,] #samo top 10 proizvajalcev
   
    slices <- man$Number
    lbls <- man$Group
    
    pct <- round(slices/sum(slices) * 100) #procenti
    lbls <- paste(lbls, pct)
    lbls <- paste(lbls,"%",sep="")
    
    pie3D(slices,labels=lbls,explode=0.1, radius = 2)
  })
})