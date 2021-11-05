## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----example, message=FALSE, warning=FALSE------------------------------------
library(dplyr)
library(loadflux)
data(djan)

df <- djan %>% 
  hydro_events(q = discharge, # Water discharge
               datetime = time, # POSISct argument
               window = 21) # Search window

head(df)

## ----interactive_plot, message=FALSE, warning=FALSE, out.width = "90%", fig.align='center'----
library(dygraphs)

df %>%
  event_plot(q = discharge, # Y-axis
             datetime = time, #X-axis
             he = he) # Hydrological events


## ----interactive_plot2, message=FALSE, warning=FALSE, out.width = "90%", fig.align='center'----
library(dygraphs)

df %>%
  event_plot(q = discharge, # Y-axis
             ssc = SS,
             datetime = time, #X-axis
             he = he) # Hydrological events


