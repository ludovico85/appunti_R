setwd("C:\\Users\\Pc\\Desktop\\wc2.1_10m_tavg")#la directory dove hai il raster.

require(raster)#serve il pacchetto raster, per installarlo install.package("raster")

R<-stack("input.tif")#carico il raster, nel mio caso si chiama input.tif

d<-dim(R)[[3]]#il numero di bande che compongono il raster (3 non è il numero di bande ma è un indice per il subset, non toccare)


#### se i valori sono minori o uguali a zero, le celle diventano 0, se maggiori di zero diventano 1

for(i in 1:d){
  
  values(R[[i]])[values(R[[i]]) <= 0] = 0
  values(R[[i]])[values(R[[i]]) > 0] = 1
}


#conteggio dei valori delle bande: il valore di ogni pixel è dato dalla somma dei casi uguale 1 (pixel con valroi maggiori di 0 o di un valore soglia)
count<-calc(R, sum)

writeRaster(count, "output.tif", format="GTiff", options=c("COMPRESS=DEFLATE"))

