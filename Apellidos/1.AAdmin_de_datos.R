###Limpieza de base de datos

library(dplyr)
library(ade4)
library(tidyr)


#Working directory
getwd()
setwd("C:/Users/Pruebas/Documents/Practica/DIRECTORIO_PROYECTO/Datos/Comun")

#SELECCION DE DATOS ÚTILES: comuna de coquimbo, variables(province, surname_father)
commoners <- read.csv("commoners.csv", sep=",", header=TRUE, fill = TRUE)
data.frame(names(commoners))
surnames<-dplyr::select(commoners,region,province,surname_father)  
data.frame(names(surnames))
surnames <- subset(surnames, region == "COQUIMBO") 
surnames<-dplyr::select(surnames,province,surname_father)
data.frame(names(surnames))

### CREACIÓN DE BASE DE DATOS PARA ÁRBOLES POR PROVINCIA 

#AGRUPACIÓN POR PROVINCIA y CONTABILIZACIÓN DE APELLIDOS
surnames %>%
group_by(province,surname_father)%>%
summarise(n()) -> X

X %>%
  pivot_wider(names_from = "surname_father", values_from = "n()") -> FINAL
FINAL[is.na(FINAL)] <-0

#CREACIÓN DE MATRIZ CSV CON ESOS DATOS
setwd("C:/Users/Pruebas/Documents/Practica/DIRECTORIO_PROYECTO/Archive")
write.csv(FINAL,"frecuencia_apellidos_prov.csv")

#BASE BINARIA (PRESENCIA 1 -AUSENCIA 0)
FINAL[FINAL > 0] <- 1

#CREACIÓN DE MATRIZ CSV CON ESOS DATOS
write.csv(FINAL,"frecuencia_apellidos_prov_binario.csv")

#CREACIÓN DE ARCHIVO NEXUS CON ESOS DATOS
