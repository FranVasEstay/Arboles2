######################Limpieza de la base de datos########################
##########################################################################

#Instalación de paquetes

library(dplyr)
library(ade4)
library(tidyr)

#Working directory

getwd()
setwd("C:/Users/Pruebas/Documents/Práctica/DIRECTORIO_PROYECTO/Datos/Comun")

#Abrir y explorar bases de datos

primera<- read.csv("all_tabulated.csv", sep=",", header=TRUE, fill = T)
segunda<- read.csv("Muestras Fondecyt 11160402 Alelos - RACK 1.csv", sep =",", header = TRUE, fill = TRUE)
data.frame(names(primera))
data.frame(names(segunda))

#Cambiar nombres de variable X

names(primera)[1]<-"Sample.Name"

#Crear variable que muestre los dos alelos.

primera$Alleles <- rep(1:2)

#eliminar variable X.1

primera$X.1 <- NULL


#Cambiar -9 y datos blancos a NA

for (i in -9) {
  primera$D3S1358[primera$D3S1358 == i] <- NA
  primera$TH01 [primera$TH01 == i] <- NA
  primera$D21S11 [primera$D21S11 == i] <- NA
  primera$D18S51 [primera$D18S51 == i] <- NA
  primera$Penta.E [primera$Penta.E == i] <- NA
  primera$D5S818 [primera$D5S818 == i] <- NA
  primera$D13S317 [primera$D13S317 == i] <- NA
  primera$D7S820 [primera$D7S820 == i] <- NA
  primera$D16S539 [primera$D16S539 == i] <- NA
  primera$CSF1PO [primera$CSF1PO == i] <- NA
  primera$Penta.D [primera$Penta.D == i] <- NA
  primera$AMEL [primera$AMEL == i] <- NA
  primera$vWA [primera$vWA == i] <- NA
  primera$D8S1179 [primera$D8S1179 == i] <- NA
  primera$TPOX [primera$TPOX == i] <- NA
  primera$FGA [primera$FGA == i] <- NA
   
}

for (i in "") {
  segunda$Allele.1 [segunda$Allele.1 == i] <- NA
  segunda$Allele.2 [segunda$Allele.2 == i] <- NA

}
 
 

################Unificar las bases de datos######################
#Transformar columnas en filas

segunda %>%
pivot_wider(names_from= Marker, values_from= c(Allele.1,Allele.2)) %>%
  as.data.frame() -> X

#Separar los alelos
x1<-X[1:17]
x1$Alleles <- (1)

x2 <- X[18:33]
x3 <-X[1]
x4 <- cbind(x2,x3)
x4$Alleles <-(2)

# cambiar nombres de variables

for (i in 1) {

names(x1)[i+1] <- "D3S1358"
names(x1)[i+2] <- "TH01"
names(x1)[i+3] <- "D21S11"
names(x1)[i+4] <- "D18S51"
names(x1)[i+5] <- "Penta.E"
names(x1)[i+6] <- "D5S818"
names(x1)[i+7] <- "D13S317"
names(x1)[i+8] <- "D7S820"
names(x1)[i+9] <- "D16S539"
names(x1)[i+10] <- "CSF1PO"
names(x1)[i+11] <- "Penta.D"
names(x1)[i+12] <- "AMEL"
names(x1)[i+13] <- "vWA"
names(x1)[i+14] <- "D8S1179"
names(x1)[i+15] <- "TPOX"
names(x1)[i+16] <- "FGA"

names(x4)[i] <- "D3S1358"
names(x4)[i+1] <- "TH01"
names(x4)[i+2] <- "D21S11"
names(x4)[i+3] <- "D18S51"
names(x4)[i+4] <- "Penta.E"
names(x4)[i+5] <- "D5S818"
names(x4)[i+6] <- "D13S317"
names(x4)[i+7] <- "D7S820"
names(x4)[i+8] <- "D16S539"
names(x4)[i+9] <- "CSF1PO"
names(x4)[i+10] <- "Penta.D"
names(x4)[i+11] <- "AMEL"
names(x4)[i+12] <- "vWA"
names(x4)[i+13] <- "D8S1179"
names(x4)[i+14] <- "TPOX"
names(x4)[i+15] <- "FGA"

}
    

#Unir bases de datos en una sola

union<- union_all(x1,x4)

#Cambiar variables a integrales

primera %>%
  str()

union %>%
  str()

as.factor(union$Sample.Name)
as.integer(union$D3S1358)
as.numeric(union$TH01)
as.numeric(union$D21S11)
as.integer(union$D18S51)
as.integer(union$`Penta.E`)
as.integer(union$D5S818)
as.integer(union$D13S317)
as.integer(union$D7S820)
as.integer(union$D16S539)
as.integer(union$CSF1PO)
as.numeric(union$`Penta.D`)
as.factor(union$AMEL)
as.integer(union$vWA)
as.integer(union$D8S1179)
as.integer(union$TPOX)
as.numeric(union$FGA)

#Base final 

mi.final <-merge(union, primera, all=T)

#Borrar otras bases 


primera <- NULL
segunda <- NULL 
X <- NULL 
x1 <- NULL 
x2 <- NULL
x3 <- NULL
x4 <- NULL
union <- NULL

# eliminar columna "AMEL"

mi.final <- subset(mi.final, select = -AMEL)

# convertir columnas (exceptuando "Sample.name" y "Alleles") a clase numérica

i <- c(2:16)
mi.final[ ,i] <- apply(mi.final[ , i], 2,
                       function(x) as.numeric(as.character(x)))
sapply(mi.final, class) # comprobar clase de cada columna

# truncar columnas que incluyen decimales (decimal corresponde a número de bases de una repetición incompleta) 

mi.final$TH01 = trunc(mi.final$TH01)
mi.final$D21S11 = trunc(mi.final$D21S11)
mi.final$Penta.E = trunc(mi.final$Penta.E)
mi.final$Penta.D = trunc(mi.final$Penta.D)
mi.final$FGA = trunc(mi.final$FGA)


rm(primera, segunda, union, X, x1, x2, x3, x4)


##########      Convertir data frame a formatos para pruebas      ##########

# generar un archivo xls para modificar formato de alelos 1 y 2

library("writexl")
write_xlsx(mi.final,"C:/Users/AM/Documents/GitHub/Arboles2/mi_final.xlsx")


# archivo "STR_ceros.csv" (generado en Excel) contiene cada marcador en dos columnas (.1 y .2)

library(tidyverse)
STR_alelos_slash <- read.csv("C:/Users/AM/Documents/GitHub/Arboles2/STR_ceros.csv",
                             header = TRUE, sep = ";", colClasses = "character", stringsAsFactors = FALSE)

STR_alelos_slash <- STR_alelos_slash %>% 
  unite( D3S1358, D3S1358.1, D3S1358.2, sep = "/", remove = TRUE) %>% 
  unite(TH01, TH01.1, TH01.2, sep = "/", remove = TRUE) %>% 
  unite(D21S11, D21S11.1, D21S11.2, sep = "/", remove = TRUE) %>% 
  unite(D18S51, D18S51.1, D18S51.2, sep = "/", remove = TRUE) %>% 
  unite(Penta_E, Penta_E.1, Penta_E.2, sep = "/", remove = TRUE) %>%
  unite(D5S818, D5S818.1, D5S818.2, sep = "/", remove = TRUE) %>% 
  unite(D13S317, D13S317.1, D13S317.2, sep = "/", remove = TRUE) %>% 
  unite(D7S820, D7S820.1, D7S820.2, sep = "/", remove = TRUE) %>% 
  unite(D16S539, D16S539.1, D16S539.2, sep = "/", remove = TRUE) %>% 
  unite(CSF1PO, CSF1PO.1, CSF1PO.2, sep = "/", remove = TRUE) %>% 
  unite(Penta_D, Penta_D.1, Penta_D.2, sep = "/", remove = TRUE) %>% 
  unite(vWA, vWA.1, vWA.2, sep = "/", remove = TRUE) %>% 
  unite(D8S1179, D8S1179.1, D8S1179.2, sep = "/", remove = TRUE) %>% 
  unite(TPOX, TPOX.1, TPOX.2, sep = "/", remove = TRUE) %>% 
  unite(FGA, FGA.1, FGA.2, sep = "/", remove = TRUE)


# remover 8 muestras no asociadas a comunidades

STR_alelos_slash <- STR_alelos_slash[ !(STR_alelos_slash$ID %in% c("AS", "DS", "JG", "MR", "NM", "VG", "WW182", "pos_ctrl")), ]

# cambiar la columna de id

row.names(STR_alelos_slash) <- STR_alelos_slash$ID 
STR_alelos_slash[1] <- NULL

# convertir data frame a objeto de clase "genind"

library(ade4)
library(adegenet)
library(ape)
library(phangorn)
library(polysat)

STR_genind <- df2genind(
  STR_alelos_slash,
  sep = "/",
  ncode = NULL,
  ind.names = NULL,
  loc.names = NULL,
  pop = ifelse(grepl("BZ", rownames(STR_alelos_slash)), "Barraza", 
               ifelse(grepl("CB", rownames(STR_alelos_slash)), "Canela Baja",
               ifelse(grepl("CA", rownames(STR_alelos_slash)), "Canelilla Ovalle",
               ifelse(grepl("LG", rownames(STR_alelos_slash)), "Castillo Mal Paso", 
               ifelse(grepl("ES", rownames(STR_alelos_slash)), "El Espinal",
               ifelse(grepl("GG", rownames(STR_alelos_slash)), "Gualliguaica",
               ifelse(grepl("HT", rownames(STR_alelos_slash)), "Huentelauquén", 
               ifelse(grepl("CL", rownames(STR_alelos_slash)), "La Calera", 
               ifelse(grepl("VP", rownames(STR_alelos_slash)), "La Polvada", 
               ifelse(grepl("MP", rownames(STR_alelos_slash)), "Monte Patria", 
               ifelse(grepl("DV", rownames(STR_alelos_slash)), "El Divisadero", 
               ifelse(grepl("EA", rownames(STR_alelos_slash)), "El Altar", 
               ifelse(grepl("MQ", rownames(STR_alelos_slash)), "Manquehua", 
               ifelse(grepl("PQ", rownames(STR_alelos_slash)), "Punitaqui", 
               ifelse(grepl("RP", rownames(STR_alelos_slash)), "Rinconada de Punitaqui", 
               ifelse(grepl("CR", rownames(STR_alelos_slash)), "La Calera", "otros")))))))))))))))),
  NA.char = "0",
  ploidy = 2L,
  type = 'codom',
  strata = NULL,
  hierarchy = NULL,
  check.ploidy = TRUE
)

# convertir objeto genind a objeto de clase "genpop"

STR_genpop <- genind2genpop(
  STR_genind,
  pop = NULL,
  quiet = TRUE,
  process.other = FALSE,
)

# convertir archivo a formato GENEPOP

library(graph4lg)
STR_for_genepop <- genind_to_genepop(STR_genind, output = "data.frame")
write.table(STR_for_genepop, file = "STR_FOR_GENEPOP.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

