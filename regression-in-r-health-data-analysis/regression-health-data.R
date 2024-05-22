---
title: "Medical Charge Predictions"
output: html_document
date: "2024-05-23"
---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=TRUE)

# Libraries
```  

## Load in the data
```{r}
df = read.csv('insurance.csv', header=TRUE)
num_cols <- unlist(lapply(df, is.numeric))
plot(df[,num_cols])
```

