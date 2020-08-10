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
