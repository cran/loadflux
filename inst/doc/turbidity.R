## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, warning=FALSE, message=FALSE--------------------------------------
library(dplyr)
library(purrr)
library(tidyr)
library(tsibble)
library(loadflux)

## ----events, out.width = "90%", fig.align='center'----------------------------
data(djanturb)
df <- hydro_events(dataframe = djanturb,
                   q = discharge,
                   datetime = time,
                   window = 21)

df %>% 
  event_plot(q = discharge,
             datetime = time,
             he = he,
             ssc = ntu,
             y2label = "Turbidity")


## ----ti_index-----------------------------------------------------------------

TI_index <- df %>% 
  group_by(he) %>% 
  nest() %>% 
  mutate(TI = map_dbl(data, ~TI(.x, ntu, time))) %>% 
  select(-data) %>% 
  ungroup()

TI_index


## ----to_tsibble---------------------------------------------------------------
library(tsibble)

df_ts <- df %>% 
  as_tsibble(key = he,
             index = time)

df_ts

## ----feat_ev------------------------------------------------------------------
library(feasts)

df_ts %>% 
  features(time,
           feat_event)


## ----stats--------------------------------------------------------------------
library(brolgar)
library(feasts)

df_ts %>% 
  features(ntu, feat_five_num)

df_ts %>% 
  features(ntu, c(feat_spectral,
                  feat_acf))


