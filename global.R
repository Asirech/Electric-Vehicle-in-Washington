options(scipen = 99) 
library(tidyverse) 
library(tidyr)
library(dplyr) 
library(readr)
library(ggplot2) 
library(plotly) 
library(glue) 
library(scales)
library(leaflet)
library(stringr)
library(shinydashboard)
library(shiny)
library(DT)

#read data 
dataset <- read.csv("Electric_Vehicle_Population_Data.csv", na.strings = "") 

#data 
df <- 
  dataset %>% 
  filter(Clean.Alternative.Fuel.Vehicle..CAFV..Eligibility == "Clean Alternative Fuel Vehicle Eligible" 
         & State == "WA" & Vehicle.Location !=("NA") & Make %in% c("TESLA","NISSAN","CHEVROLET","FORD","KIA","BMW") )


df$Vehicle.Location<- gsub("[()]","",df$Vehicle.Location)
df['Year'] <- df$Model.Year  

df <- separate(df, "Vehicle.Location",c("point","lat","lng"),sep= " ", remove=F)

df <- df %>%
  mutate (
    County = as.factor(County),
    City = as.factor(City),
    State = as.factor(State),
    Model.Year = as.factor(Model.Year),
    Year = as.numeric(Year),
    Make = as.factor(Make),
    Model = as.factor(Model),
    lat = as.double(lat),
    lng = as.double(lng),
    Electric.Vehicle.Type = as.factor(Electric.Vehicle.Type),
    Clean.Alternative.Fuel.Vehicle..CAFV..Eligibility = as.factor(Clean.Alternative.Fuel.Vehicle..CAFV..Eligibility)
  )



