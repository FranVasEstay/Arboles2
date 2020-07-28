###Limpieza de base de datos

library(dplyr)

#Working directory
getwd()
setwd("C:/Users/Pruebas/Documents/Practica/DIRECTORIO_PROYECTO/Datos/Comun")

#SELECCION DE DATOS ÚTILES (community, surname_father)
commoners <- read.csv("commoners.csv", sep=",", header=TRUE, fill = TRUE)
data.frame(names(commoners))
surnames<-dplyr::select(commoners, community,surname_father)  
data.frame(names(surnames))
surnames %>%
group_by(community, add = FALSE) 

