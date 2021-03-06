#install.packages(c("conjoint","DT","shinyjs","shiny","devtools","dplyr","digest","likert","ggplot2"))

#install.packages("modeest")
#install.packages(c("reshape","RcolorBrewer","ggthemes","stringr"))


#install.packages("tidyr")

#install.packages("choiceDes")
#install.packages("httpuv")


library(httpuv)
library(modeest)
library(conjoint)
library(DT)
library(shinyjs)
library(shiny)
library(devtools)
library(dplyr)
library(digest)
library(likert)
library(ggplot2)
library(reshape2)
library(RColorBrewer)
library(ggthemes)
library(stringr)
library(tidyr)
library(choiceDes)
library(data.table)
library(rdrop2)



source("choiceDataTable.R")
#source("likertQuestions.R")


NUM_PAGES <- 12

#likert_questions <- paste("Question", 1:12)
#Anx_questions<-paste("Question", 1:4)


#likert_choices <- c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")
#levelanx_choices<-c("Not Anxious","Slightly Anxious","Fairly Anxious","Very Anxious", "Extremely Anxious")


outputDir <- "experiment"



#fieldsMandatory <- c("age", "gender")

#labelMandatory <- function(label) {
  #tagList(
    #label,
    #span("*", class = "mandatory_star")
  #)
#}

# appCSS <-
#  ".mandatory_star { color: red; }"

fieldsAll <- c("var1","min_brush","var2","min_floss","age","gender","visit_freq1","visit_freq2","visit_reason","text1","alchohol","ethnicity","text2","oral_condition","visit_pay","visit_dread","smoking_status","education","sug_bev","working_status","profession","region","Eng.region","Scot.city","Wal.city","Ire.city","Feed1","Feed2","Feed3","Feed4","Feed5","Feed6","Feed7","Feed8")
#responsesDir <- file.path("responses")
epochTime <- function() {
  as.integer(Sys.time())
}

#responses_file_path <- file.path("responses", list.files("responses"))
#list_responses <- lapply(responses_file_path, read.csv)
#responses_df <- do.call(what = rbind, args = list_responses)

filesInfo <- drop_dir(outputDir)
filePaths <- filesInfo$path_lower  


df <- data.frame(var1=integer(),min_brush=integer(),var2=integer(),min_floss=integer(),age=integer(),gender=integer(),visit_freq1=integer(),visit_freq2=integer(),visit_reason=integer(),text1=character(),alchohol=integer(),ethnicity=integer(),text2=character(),oral_condition=integer(),visit_pay=integer(),visit_dread=integer(),smoking_status=integer(),education=integer(),sug_bev=integer(),working_status=integer(),profession=integer(),region=integer(),Eng.region=character(),Scot.city=character(),Wal.city=character(),Ire.city=character(),Feed1=integer(),Feed2=integer(),Feed3=integer(),Feed4=integer(),Feed5=character(),Feed6=character(),Feed7=character(),Feed8=character(),choice1=integer(),choice2=integer(),choice3=integer(),choice4=integer(),choice5=integer(),choice6=integer(),choice7=integer(),choice8=integer(),block=integer(),timestamp=integer(), stringsAsFactors=FALSE)
df <- apply(df,2,as.character)

data <-drop_read_csv(filePaths[length(filePaths)])
#data <- lapply(filePaths, drop_read_csv, stringsAsFactors = FALSE)

# Concatenate all data together into one data.frame
#data <- do.call(rbind, data )





dat.frame<-as.data.frame(data)
df<-dat.frame

dat.frame.new<-mutate(dat.frame,brushing_intensity=dat.frame$var1*dat.frame$min_brush,flossing_intensity=dat.frame$var2*dat.frame$min_floss,both_intensities=dat.frame$var1*dat.frame$min_brush+dat.frame$var2*dat.frame$min_floss)
quantile(dat.frame.new$both_intensities,prob=0.5,na.rm = TRUE)

dat.count<-as.data.frame(count(dat.frame.new,dat.frame.new$oral_condition))















#nulls<-as.data.frame(matrix(0,nrow=10,ncol=5))

#for (i in 1:10){
#exp.data<-t(as.data.frame(rev(table(dat.frame[ ,11+i]))))
#exp.data.row<-as.numeric(exp.data[-c(1),])
#nulls[i,]<-exp.data.row
#}

#colnames(nulls)<-c("Neutral","Strongly Disagree","Disagree","Strongly Agree","Agree")
#rownames(nulls)<-paste("Questions",1:10)

#correct_nulls<-cbind(nulls[ ,2],nulls[ ,3],nulls[ ,1],nulls[ ,5],nulls[ ,4])

#for (i in 1:10){
#for (j in 1:5){
#correct_nulls[i,j]<-correct_nulls[i,j]/sum(correct_nulls[i,])
#}
#}
#correct_nulls
#first_col<-c("Question1","Question2","Question3","Question4","Question5","Question6","Question7","Question8","Question9","Question10")
#fir<-as.data.frame(first_col)

#midvalues<-correct_nulls[ ,3]/2

#correct_nulls2<-cbind(fir,correct_nulls[ ,1:2],midvalues,midvalues,correct_nulls[ ,4:5])

#correct_nulls2
#colnames(correct_nulls2)<-c("outcome","Strongly Disagree","Disagree","Midlow","Midhigh","Agree","Strongly Agree")
#correct_nulls2

#numlevels<-5
#temp.rows<-10
#pal<-brewer.pal(5,"RdBu")
#pal[3]<-"#DFDFDF"
#legend.pal<-pal

#pal<-c(pal[1:2],pal[3],pal[3],pal[4:5])
#pal

#correct_nulls3<-melt(correct_nulls2,id="outcome")
#correct_nulls3$col<-rep(pal,each=10)
#correct_nulls3$value<-correct_nulls3$value*100
#correct_nulls3$outcome<-str_wrap(correct_nulls3$outcome, width = 40)

#correct_nulls3$outcome<-factor(correct_nulls3$outcome,levels=correct_nulls2$outcome[order(-(correct_nulls2[,5]+correct_nulls2[,6]+correct_nulls2[,7]))])

#correct_nulls3