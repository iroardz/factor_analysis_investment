## Check dependencies ----

if (!require("factoextra")) install.packages("factoextra")
if (!require("cluster")) install.packages("cluster")
if (!require("igraph")) install.packages("igraph")
if (!require("tidygraph")) install.packages("tidygraph")
if (!require("ggraph")) install.packages("ggraph")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("scales")) install.packages("scales")
if (!require("mclust")) install.packages("mclust")
if (!require("dbscan")) install.packages("dbscan")
if (!require("fpc")) install.packages("fpc")
if (!require("clustertend")) install.packages("clustertend")

## Set up ----

library("factoextra")
library("cluster")
library("igraph")
library("tidygraph")
library("ggraph")
library("scales")
library("mclust")
library("dbscan")
library("fpc")
library("clustertend")

#Importar la base de datos.
BaseDatos <- read_excel("data/data.xlsx",
                        sheet = "PCA", 
                        range = "A3:G28")
BaseDatos <- BaseDatos[,2:7]

#############################################################################

#Define the number of clusters.
fviz_nbclust(x = BaseDatos, FUNcluster = cluster::pam, method = "wss", k.max = 10,
             diss = dist(BaseDatos, method = "manhattan"))


#Clustering K-Medoids
set.seed(123)
pam_clusters <- pam(x = BaseDatos, k = 4, metric = "manhattan")
pam_clusters


#plot
fviz_cluster(object = pam_clusters, data = BaseDatos, ellipse.type = "t",
             repel = TRUE) +
  theme_bw() +
  labs(title = "An?lisis de Conglomerados (K-Medoids)") +
  theme(legend.position = "none")

#write.csv(pam_clusters$clustering, file="Cl?sters.csv")