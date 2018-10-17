#cand <- dcm.design.gencand(c(3,3,4,4,4,4,4))
#colnames(cand)<-c("dental check up cost","transport time","Amount of dietary advice","Amount of hygiene advice", "Amount of fluoride varnish delivery", "Waiting time for the appointment","Dental advice provided by")

#set.seed(1)
#des <- dcm.design.cand(cand,9,8,2)
#des$levels

#cal_1<-function (data){
#  fact1<-as.factor(data[ ,4])
#  levels(fact1)<-c("20","50","100")
#  fact2<-as.factor(data[ ,5])
#  levels(fact2)<-c("0 mins","15 mins","30 mins","45 mins")
#  fact3<-as.factor(data[ ,6])
#  levels(fact3)<-c("0 mins","3 mins","6 mins", "9 mins")
#  fact4<-as.factor(data[ ,7])
#  levels(fact4)<-c("0 mins","3 mins","6 mins","12 mins")
#  fact5<-as.factor(data[ ,8])
#  levels(fact5)<-c("0 mins","3 mins","5 mins","7.5 mins")
#  fact6<-as.factor(data[ ,9])
#  levels(fact6)<-c("0 days","1 day","10 days","15 days")
#  fact7<-as.factor(data[ ,8])
#  levels(fact7)<-c("dentist","dental hygienist","dental therapist","dental nurse")
  
#  cbind(as.data.frame(fact1),as.data.frame(fact2),as.data.frame(fact3),as.data.frame(fact4),as.data.frame(fact5),as.data.frame(fact6),as.data.frame(fact7))
#}

#data_sets<-cal_1(des$levels)


#df<-cbind(des$levels[,1:3],data_sets)
#colnames(df)<-c("card","vers","task","dental check up cost","transport time","Amount of dietary advice","Amount of hygiene advice", "Amount of fluoride varnish delivery", "Waiting time for the appointment","Dental advice provided by")

#dat<-split(df, (seq(nrow(df))-1) %/% 16) 
#names(dat)<-c("block1","block2","block3","block4","block5","block6","block7","block8","block9")


#for (i in 1:9){ 
  
#  dat[[i]]<-split(dat[[i]],(seq(nrow(dat[[i]]))-1) %/% 2)
#}


#data_read<-lapply(dat, function(x) t(as.data.frame(x)))
#data_read1<-as.data.frame(data_read)

#data_read_choices_block1<-split(data_read1[ ,1:2],(seq(nrow(data_read1[ ,1:2]))-1) %/% 10)
#data_read_choices_block2<-split(data_read1[ ,3:4],(seq(nrow(data_read1[ ,3:4]))-1) %/% 10)
#data_read_choices_block3<-split(data_read1[ ,5:6],(seq(nrow(data_read1[ ,5:6]))-1) %/% 10)
#data_read_choices_block4<-split(data_read1[ ,7:8],(seq(nrow(data_read1[ ,7:8]))-1) %/% 10)
#data_read_choices_block5<-split(data_read1[ ,9:10],(seq(nrow(data_read1[ ,9:10]))-1) %/% 10)
#data_read_choices_block6<-split(data_read1[ ,11:12],(seq(nrow(data_read1[ ,11:12]))-1) %/% 10)
#data_read_choices_block7<-split(data_read1[ ,13:14],(seq(nrow(data_read1[ ,13:14]))-1) %/% 10)
#data_read_choices_block8<-split(data_read1[ ,15:16],(seq(nrow(data_read1[ ,15:16]))-1) %/% 10)
#data_read_choices_block9<-split(data_read1[ ,17:18],(seq(nrow(data_read1[ ,17:18]))-1) %/% 10)

#Choice_scenarios_for_each_block_sep<-function (data){ 
# for (i in 1:8){ 
#    rownames(data[[i]])<-c("card","vers","task","Cost of a dental check-up","Transport time to reach the practice","Amount of dietary advice","Amount of hygiene advice", "Amount of fluoride varnish delivery", "Waiting time for the appointment","Dental advice provided by")
#    colnames(data[[i]])<-c("Dental Practice 1","Dental Practice 2")
#    data[[i]]<-data[[i]][-c(1,2,3),]
#  }
#  data
#}


assign_blocks <- function(n) {
  #r <- runif(1)
  #if(r > 0.5) {
  if(n == 1) {
    return(readRDS("model1.data.rds"))
  }else if(n==2) {
    return(readRDS("model2.data.rds"))
  }
  else if(n==3){
    return(readRDS("model3.data.rds"))
  }
  
  else if(n==4) {return(readRDS("model4.data.rds"))}
  else if(n==5){return(readRDS("model5.data.rds"))}
  else if(n==6){return(readRDS("model6.data.rds"))}
  else if(n==7){return(readRDS("model7.data.rds"))}
  else if(n==8){return(readRDS("model8.data.rds"))}
  else{return(readRDS("model9.data.rds"))}
  
}

set.seed(Sys.time())
n<-sample(1:9,1)
print(n)
alts <- assign_blocks(n)

server <- function(input, output, session) {
  
  
  #observe(print(alts))
  
  rv <- reactiveValues(page = 1)
  
  observe({
    toggleState(id = "prevBtn", condition = rv$page > 1 &  rv$page <NUM_PAGES)
    toggleState(id = "nextBtn", condition = rv$page < NUM_PAGES)
    hide(selector = ".page")
    show(sprintf("step%s", rv$page))
  })
  
  observe({
    if(rv$page == 3) {
      if(length(a1()) == 0) {
        disable(id = "nextBtn")
        return()
      }  else {
        enable(id = "nextBtn")
      }
    }
  })
  
  observe({
    if(rv$page == 4) {
      if(length(a2()) == 0 ) {
        disable(id = "nextBtn")
        return()
      } else {
        enable(id = "nextBtn")
      }
    }
  })
  
  observe({
    if(rv$page == 5) {
      if(length(a3()) == 0 ) {
        disable(id = "nextBtn")
        return()
      }  else {
        enable(id = "nextBtn")
      }
    }
  })
  
  observe({
    if(rv$page == 6) {
      if(length(a4()) == 0) {
        disable(id = "nextBtn")
        return()
      } else {
        enable(id = "nextBtn")
      }
    }
  })
  
  observe({
    if(rv$page == 7) {
      if(length(a5()) == 0) {
        disable(id = "nextBtn")
        return()
      }  else {
        enable(id = "nextBtn")
      }
    }
  })
  
  observe({
    if(rv$page == 8) {
      if(length(a6()) == 0) {
        disable(id = "nextBtn")
        return()
      }  else {
        enable(id = "nextBtn")
      }
    }
  })
  
  observe({
    if(rv$page == 9) {
      if(length(a7()) == 0) {
        disable(id = "nextBtn")
        return()
      }  else {
        enable(id = "nextBtn")
      }
    }
  })
  
  observe({
    if(rv$page == 10) {
      if(length(a8()) == 0) {
        disable(id = "submit")
        return()
      }  else {
        enable(id = "submit")
      }
    }
  })
  
  navPage <- function(direction) {
    rv$page <- rv$page + direction
  }
  
  observeEvent(input$prevBtn, navPage(-1))
  observeEvent(input$nextBtn, navPage(1))
  
  
  x<-reactive({
    input$var1*input$min_brush
  })
  
  y<-reactive({
    input$var2*input$min_floss
  })
  
myPlot <- function(){
    
    How_preventive_am_i<-gather(dat.frame.new,value="value",key="type",brushing_intensity,flossing_intensity)
    ggplot(How_preventive_am_i, aes(x=value,color=type,fill=type,alpha=0.6)) +
      scale_fill_manual(values=c("red","blue"))+
      #geom_line()+
      geom_density(adjust=5)+
      
      geom_vline(xintercept =x(),linetype="dashed",colour="red")+
      geom_vline(xintercept = y(),linetype="dashed",colour="blue")
}

output$distPlot<-renderPlot({
  myPlot()
})
  mySecondPlot<-function(){
    oral_sit<-gather(dat.frame.new,value="value",key="type",oral_condition)
    ggplot(oral_sit, aes(x=value,color=type,fill=type,alpha=0.6)) +
      scale_fill_manual(values="blue")+
      #geom_line()+
      geom_density(adjust=5)+
      geom_vline(xintercept = x(),linetype="dashed",colour="blue")
  }
  output$SecondDistPlot<-renderPlot({
    mySecondPlot() 
  })
  
    
    
  graph.data<-reactive({
  input$var1*input$min_brush+input$var2*input$min_floss
  })
  
  output$message <- renderPrint({
    if (graph.data() <= isolate ({quantile(dat.frame.new$both_intensities,prob=0.5)})) {
     print("You belong to the 50 percent LEAST preventive people")
    }
    else {
      print("You belong to the 50 percent MOST preventive people")
    }
    
  })
  
  observe({
    # check if all mandatory fields have a value
    mandatoryFilled <-
      vapply(fieldsMandatory,
             function(x) {
               !is.null(input[[x]]) && input[[x]] != ""
             },
             logical(1))
    mandatoryFilled <- all(mandatoryFilled)
    # enable/disable the submit button
    shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
  })
  
  formData <- reactive({
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- c(data, choice1 = a1(), choice2 = a2(), choice3 = a3(),
              choice4 = a4(), choice5 = a5(), choice6 = a6(),
              
              choice7 = a7(), choice8 = a8(), block=print(n))
    
    data <- c(data, timestamp = epochTime())
    data <- t(data)
    data
  })
  
  
  saveData <- function(data) {
    fileName <- sprintf("%s_%s.csv",
                        epochTime(),
                        digest::digest(data))
    
    write.csv(
      x = data,
      file = file.path(responsesDir, fileName),
      row.names = FALSE,
      quote = TRUE
    )
  }
  
  observeEvent(input$submit, {
    saveData(formData())
    
    shinyjs::hide("lastpage")
    
    
    shinyjs::show("thankyou_msg")
    shinyjs::hide("pager")
  })
  
  
  #observe({
    #toggle(id = "last page choice", condition =input$submit )
  #})
  
  # 
  # a1 <- callModule(choiceDataTable, "one", d1)
  # a2 <- callModule(choiceDataTable, "two", d2)
  # a3 <- callModule(choiceDataTable, "three", d3)
  # a4 <- callModule(choiceDataTable, "four", d4)
  # 
  # a5 <- callModule(choiceDataTable, "five", d5)
  # a6 <- callModule(choiceDataTable, "six", d6)
  # a7 <- callModule(choiceDataTable, "seven", d7)
  # a8 <- callModule(choiceDataTable, "eight", d8)
  # 
  a1 <- callModule(choiceDataTable, "one", alts[[1]])
  a2 <- callModule(choiceDataTable, "two", alts[[2]])
  a3 <- callModule(choiceDataTable, "three", alts[[3]])
  a4 <- callModule(choiceDataTable, "four", alts[[4]])
  
  a5 <- callModule(choiceDataTable, "five", alts[[5]])
  a6 <- callModule(choiceDataTable, "six", alts[[6]])
  a7 <- callModule(choiceDataTable, "seven", alts[[7]])
  a8 <- callModule(choiceDataTable, "eight", alts[[8]])
  
  #likerts <- callModule(likertQuestions, "likert")
  
  
  #levelanxes <- callModule(likertQuestions,"levelanx")
  
  
  #output$likert_plot <- renderPlot({
    #likert_frame <- dat.frame[, grepl("likert", names(dat.frame))]
    #likert_frame[ ,1:12] <- lapply(likert_frame[,1:12], function(x) factor(x, levels = likert_choices))
    
    #names(likert_frame) <- likert_questions
    
    #likert_summ <- likert(likert_frame[ ,1:12])
    #plot(likert_summ, group.order = likert_questions)
  #})
  
  #output$Anx_plot<-renderPlot({
    #Anx_frame <- dat.frame[, grepl("likert", names(dat.frame))] 
    #Anx_frame[ ,1:4] <- lapply(Anx_frame[ ,13:16], function(x) factor(x, levels = levelanx_choices))
    #names(Anx_frame)<- Anx_questions
    
    #Anx_summ<-likert(Anx_frame[ ,1:4])
    #plot(Anx_summ, group.order=Anx_questions)
  #})
  
  output$downloadfirstplot<-downloadHandler(
    filename=function(){
      
    paste("distribution-plot","png",sep=".")
      
      },
    
    content<-function(file){
      png(file)
      print(myPlot())
      dev.off()
    }
  )
  
  
}


#formdata2<-reactive({ 

#a<-factor(input$likert)
#correct_nulls3$lines<-rep(a,6)

#highs<-na.omit(correct_nulls3[(length(correct_nulls3[,1])/2)+1:length(correct_nulls3[,1]),])
#lows<-na.omit(correct_nulls3[1:(length(correct_nulls3[,1])/2),])

#rownames(highs)<-c(1:30)
#highs$Midhigh<-rep(highs[1:10,3],3)
#highs$Agree<-rep(highs[11:20,3],3)
#highs$StronglyAgree<-rep(highs[21:30,3],3)
#highs$res<-rep(0,30)

#for (i in 1:nrow(highs)){
#highs[i,9]<- if (highs[i,5]== "Midhigh") highs[i,6] else if(highs[i,5] == "Agree") highs[i,6]+highs[i,7] else highs[i,6]+highs[i,7]+highs[i,8]
#}

#nrow(highs)
#highs$ind<-rep(0,30)

#for (i in 1:nrow(highs)){

#ifelse(highs[i,2]==correct_nulls3[i,5],highs[i,10]<-highs[i,9],highs[i,10]<-0) 
#}

#lows <- lows[rev(rownames(lows)),]
#rownames(lows)<-c(1:30)


#lows$Midlow<-rep(lows[1:10,3],3)
#lows$Disagree<-rep(lows[11:20,3],3)
#lows$StronglyDisagree<-rep(lows[21:30,3],3)



#lows$res<-rep(0,30)

#for (i in 1:nrow(lows)){
#lows[i,9]<- if (lows[i,5]== "Midlow") lows[i,6] else if(lows[i,5] == "Disagree") lows[i,6]+lows[i,7] else lows[i,6]+lows[i,7]+lows[i,8]
#}


#nrow(lows)
#lows$ind<-rep(0,30)

#for (i in 1:nrow(lows)){

#ifelse(lows[i,2]==lows[i,5],lows[i,10]<-lows[i,9],lows[i,10]<-0) 
#}
#})

#output$likert_plot <- renderPlot({
#ggplot() + geom_bar(data=highs, aes(x = outcome, y=value, group=lines, fill=col), position="stack", stat="identity") +
# geom_bar(data=lows, aes(x = outcome, y=-value,group=lines,fill=col), position="stack", stat="identity") +
#geom_hline(yintercept = 0, color =c("black")) +
#geom_line(data=highs,aes(x=outcome,y=ind))+
#geom_line(data=lows,aes(x=outcome,y=-ind))+
#scale_fill_identity("Percent", labels = mylevels, breaks=legend.pal, guide="legend")+  
#theme_fivethirtyeight() + 
#coord_flip() +
#labs(title=mytitle, y="",x="") +
#theme(plot.title = element_text(size=14, hjust=0.5)) +
#theme(axis.text.y = element_text(hjust=0)) +
#theme(legend.position = "bottom") +
#scale_y_continuous(breaks=seq(-100,100,25), limits=c(-100,100))
#})