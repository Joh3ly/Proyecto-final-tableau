#Cargar paquetes----
library(tidyverse)
library(openxlsx)
library(magrittr)
library(dplyr)
library(tibble)

#Caragamos datos
df<-read.xlsx('directorio_companias.xlsx')

df<-tibble::as_tibble(df)
glimpse(df)

df1<-df %>% rename(EXPEDIENTE=X2,RUC=X3,NOMBRE=X4,SITUACION_LEGAL=X5,FECHA_CONSTITUCION=X6,TIPO=X7, PAIS=X8,REGION=X9,
                  PROVINCIA=X10,CANTON=X11,CIUDAD=X12,TELEFONO=X17,REPRESENTANTE=X18,CARGO=X19,CAPITAL_SUSCRITO=X20,
                  CIIU_NIVEL1=X21,CIUU_NIVEL6=X22,ULTIMO_BALANCE=X23) %>% 
  select(EXPEDIENTE,RUC,NOMBRE,SITUACION_LEGAL,FECHA_CONSTITUCION,TIPO, PAIS,REGION,PROVINCIA,CANTON,CIUDAD,TELEFONO
         ,REPRESENTANTE,CARGO,CAPITAL_SUSCRITO,CIIU_NIVEL1,CIUU_NIVEL6,ULTIMO_BALANCE) %>% view()

df1 <- df1[-(1:4), ] 
df1<-tibble::as_tibble(df1)

df1<-na.omit(df1)


#cambiamos los tipos de datos
df1<-df1 %>% mutate(CAPITAL_SUSCRITO=as.double(gsub(",", ".", gsub("\\.", "", CAPITAL_SUSCRITO))), 
                    ULTIMO_BALANCE = as.Date(paste0(ULTIMO_BALANCE, "-01-01")))


glimpse(df1)
#guardamos nuestro archivo
setwd("C:/Users/Usuario/OneDrive/Escritorio/JOHE ND/R/Proyecto-final-tableau")

write.table(df1,"companies.txt")
