# Some questions to address


## General questions
1. Hay que darle una vuelta a si es necesario tantas dependencias. Porque luego para mantenerlo puede ser un infierno. Lo ideal sería tener como dependencias ```mlr3```, ```phyloseq``` y ```ggplot2```. Pero estamos añadiendo cada vez más, y de librerías muy grandes, para utilizar únicamente una o dos funciones de ellas. 
2. Nos interesa añadir métodos no-supervisados? Pensándolo un poco mejor, sería interesante acotar el pipeline únicamente a modelos supervisados (classification, regression, survival and longitudinal). De esta manera, podemos enfocar los plots a la variable respuesta que se quiera predecir. 


## About plots
1. Hay que tener muy claro con que transformación de las muestras se debe hacer cada tipo de ploteado. O por ejemplo, cuando hacemos el calculo de la richness, si es necesaria alguna transformación previa. 
2. No será mejor hacer los plots todos con ggplot? En vez de pillar funciones ya hechas por otras personas? Podemos definir unos cuantos plots interesantes y hacerlos nosotros mismos.
2. Qué paleta de colores elegimos?
