# LEEME

Proyecto de creacion de arboles para STRs y apellidos

Lenguajes: R

## Carpetas y Archivos 

###Apellidos
- **1.AAdmin_de_datos** Administracion de base de datos commoners. Lenguaje R versión 3.5.3
- **frecuencia_apellidos_prov** Matriz de frecuencias de apellidos por provincia en archivo .csv
- **frecuencia_apellidos_prov_binario** Matriz binaria (presencia[1]/ Ausencia[1]) de apellidos por provincia en archivo .csv
- **frecuencias_apellidos** Matriz de frecuencia de apellidos por comunidad en archivo .csv
- **frecuencias_apellidos_binarios** Matriz binaria (presencia[1]/ ausencia [0]) de apellidos por comunidad en archivo .csv

###STR
- **1.SAdmin_de_datos** Administracion de base de datos de STRs. Lenguaje R versión 3.5.3
La base de datos "mi_final" es la base de datos unificada entre strs antes y después del 2018.
Los datos originalmente marcados como -9, OL o con casillas en blanco fueron catalogados como NA
- **STR_ceros.csv** Matriz de datos usado con el script Formatos.R 
- **Formatos.R** Cambios de formato en R para creación de Genepop y Genedist.
- **NJ_FST_POP** Árbol de comunidades por Neighbor-joining, con matriz de distancia FST (Latter,1972), con el software POPULATIONS 1.2.32.
- **NJ_GOLD_POP** Árbol de comunidades por Neighbor-joining, con matriz de distancia GOLDSTEIN et al (1995a) dmu2, con el software POPULATIONS 1.2.32.
- **NJ_NEI_STR** Árbol de comunidades por Neighbor-joining, con matriz de distancia Nei's standard genetic distanc Ds (Nei et al , 1972) , con el software POPULATIONS 1.2.32.
- **UPGMA_FST_POP**Árbol de comunidades por UPGMA, con matriz de distancia FST (Latter,1972), con el software POPULATIONS 1.2.32.
- **UPGMA_GOLD_POP** Árbol de comunidades por UPGMA, con matriz de distancia GOLDSTEIN et al (1995a) dmu2, con el software POPULATIONS 1.2.32.
- **UPGMA_NEI_STR** Árbol de comunidades por UPGMA, con matriz de distancia Nei's standard genetic distanc Ds (Nei et al , 1972) , con el software POPULATIONS 1.2.32.





