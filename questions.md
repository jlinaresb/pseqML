# Some questions to address


## General questions
1. En los métodos de ploteado, estamos usando la libreria [phylosmith](https://schuyler-smith.github.io/phylosmith/) para todos los plots. Se puede subir a Bioconductor con dependencias de paquetes que no estén en Bioconductor o CRAN?
2. Hay que darle una vuelta a si es necesario tantas dependencias. Porque luego para mantenerlo puede ser un infierno. Lo ideal sería tener como dependencias ```mlr``` y ```phyloseq```. Pero estamos añadiendo cada vez más, y de librerías muy grandes, para utilizar únicamente una o dos funciones de ellas. 


## About plots
1. Hay que tener muy claro con que transformación de las muestras se debe hacer cada tipo de ploteado. O por ejemplo, cuando hacemos el calculo de la richness, si es necesaria alguna transformación previa. 
2. No será mejor hacer los plots todos con ggplot? En vez de pillar funciones ya hechas por otras personas? Podemos definir unos cuantos plots interesantes y hacerlos nosotros mismos.
