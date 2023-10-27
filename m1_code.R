library(tidyverse)
library(readxl)
library(h2o)
library(lime)
library(recipes)

# load data
raw1 <- read.csv("WA_Fn-UseC_-HR-Employee-Attrition.csv")

df1 <- raw1 |> mutate_if(is.character, as.factor) |> 
        select(Attrition, everything())

rec_obj <- df1 |> recipe(formula = Attrition ~ .) |> 
        step_rm(EmployeeNumber) |> 
        step_zv(all_predictors()) |> 
        step_center(all_numeric()) |> 
        step_scale(all_numeric()) |> 
        prep(data = df1)
     
df1 <- bake(rec_obj, new_data = df1)
glimpse(df1)

