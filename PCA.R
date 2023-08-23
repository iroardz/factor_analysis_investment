## Check dependencies ----

if (!require("readr")) install.packages("readr")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("scales")) install.packages("scales")
if (!require("ggplot2")) install.packages("ggplot2")

## Set up ----

library(tidyverse)
library(readr)
library(scales)
library(ggplot2)


#read data.
BaseDatos <- read_excel(
  "data/data.xlsx", 
  sheet = "Base de Datos", 
  range = "D2:AB122")

#variable mean.
apply(X = BaseDatos, MARGIN = 2, FUN = mean)

#variance.
apply(X = BaseDatos, MARGIN = 2, FUN = var)

#Standardize (Rescale) Variables.
Base_Datos <- data.frame(lapply(BaseDatos,function(x) rescale(x)))

#principal component analysis
PCA <- prcomp(Base_Datos)

#new variables
PCA_Base <- PCA$rotation
#write.csv(PCA_Base, file="PCA.csv")

#plot
biplot(x=PCA,scale=0,cex=0.6,col=c("blue","brown"))

#Variance Explained by PCA
Pr_Varianza <- PCA$sdev^2 / sum(PCA$sdev^2)
Pr_Varianza

Pr_Varianza_Acum <- cumsum(Pr_Varianza)
Pr_Varianza_Acum

#Varianza Chart Explained
ggplot(data = data.frame(Pr_Varianza_Acum, pc = 1:25),
       aes(x = pc, y = Pr_Varianza_Acum, group = 1)) +
  geom_point() +
  geom_line() +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")
