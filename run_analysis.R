# ¡ Cambie esto a la ubicación del archivo de origen!

log  <-  función ( ... ) {
  cat ( " [run_analysis.R] " , ... , " \ n " , sep = " " )
}

libro de códigos  <-  función ( ... ) {
  cat ( ... , " \ n " , file = targetCodebookFilePath , append = TRUE , sep = " " )
}

vars  <- ls ()
vars  <-  vars [which ( vars ! = " mergedData " )]
# rm (lista = vars)
depurar  <-  FALSO

log ( " DEPURACIÓN: " , depurar )
log ( " workingDir:` " , getwd (), " ` " )


si ( debug  && existe ( " mergedData " )) {
  rm ( mergedData )
}

# libs
biblioteca ( RCurl )
biblioteca ( reshape2 )


# datos
fileUrl  <-  " https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
zipDir  <-  " Conjunto de datos UCI HAR "
targetZipFile  <-  " data.zip "
targetResultFile  <-  " tidy_data.txt "
dataPath  <-  " ./data "
targetZipFilePath  <- file.path ( dataPath , targetZipFile )
targetResultFilePath  <- file.path ( dataPath , targetResultFile )

# libro de códigos
targetCodebookFilePath  <-  " ./CodeBook.md "
file.remove ( targetCodebookFilePath )
libro de códigos ( " # Libro de códigos " )
libro de códigos ( " generado " , as.character (Sys.time ()), " durante el origen de` run_analysis.R` " )
libro de códigos ( " " )  

si ( ! existe ( " keyColumns " )) {
  keyColumns  << - c ()
}


si ( ! existe ( " featureColumns " )) {
  featureColumns  << - c ()
}

libro de códigos ( " ## Acciones realizadas en datos: " )

# crear ruta
libro de códigos ( " * crear directorio de datos` " , ruta de datos , " ` " )
if ( ! file.exists ( dataPath )) {
  log ( " crear ruta:` " , dataPath , " ` " )
  dir.create ( ruta de datos )
}


# descargar archivo .zip si no existe
if ( debug ) {file.remove ( filePath )}

libro de códigos ( " * descargando archivo zip: [ " , fileUrl , " ] ( " , fileUrl , " ) a` " , dataPath , " ` " )
if ( ! file.exists ( targetZipFilePath )) {
  log ( " descargando archivo zip:` " , fileUrl , " ` " )
  binaryData  <- getBinaryURL ( fileUrl , ssl.verifypeer = FALSE , followlocation = TRUE )
  log ( " escribiendo archivo zip:` " , targetZipFilePath , " ` " )
  fileHandle  <- archivo ( targetZipFilePath , open = " wb " )
  writeBin ( binaryData , fileHandle )  
  cerrar ( fileHandle )  
  rm ( binaryData )
} más {
  log ( " el archivo zip ya existe:` " , targetZipFilePath , " ` " )
}

# descomprimir si aún no existe
extractedZipPath  <- file.path ( rutaDatos , zipDir )
libro de códigos ( " * extracción de archivos zip:` " , targetZipFilePath , " `a` " , extractedZipPath , " ` " )
si ( ! File.Exists ( extractedZipPath ) ||  depuración ) {
  log ( " descomprimir archivo:` " , targetZipFilePath , " ` a` " , dataPath , " ` " )
  descomprimir ( targetZipFilePath , exdir = dataPath , sobrescribir = TRUE )
} más {
  log ( " archivo zip ya extraído en:` " , extractZipPath , " ` " )
}

DirList  <- list.files ( extractedZipPath , recursivas = TRUE )
  

# cargue todos los archivos .txt de entrenamiento y prueba en la memoria: ignorando las carpetas 'Señales inerciales'
sanitizedDirList  <-  dirList [ ! grepl ( " Inercial " , dirList ) & grepl ( " prueba | tren " , dirList )]

libro de códigos ( " * fusionando todos los archivos * _test.txt y * _train.txt en un conjunto de datos:` mergedData` " )
si ( ! existe ( " mergedData " ) ||  depurar ) {
  log ( " cargar archivos .txt: " )
  para ( dataFile  en  sanitizedDirList ) {
    # generar parámetros basados ​​en archivosc
    paramName  <- paste0 ( " data_ " , tolower (sub ( " ^. * / ([^ \\ .] +). * $ " , " \\ 1 " , dataFile , perl = TRUE )))
    txtfile  <- file.path ( extractedZipPath , ArchivoDeDatos )
    log ( " \ t -` " , txtfile , " `` en var " , paramName , " ` " )
    tableData  <- read.table ( txtFile )  
    asignar ( paramName , tableData )
    rm (datos de tabla )
  }
  
  
  
  # debe tener estas variables (verifique a través de ls ()):
  # data_subject_test
  # data_subject_train
  # data_x_test
  # data_x_train
  # data_y_test
  # data_y_train
 
  # Asignación / Proyecto:
  # 1. Fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de datos.
  log ( " [# 1] Fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de datos " ).
  
  # combine datos de prueba y entrenamiento como filas en 3 conjuntos de datos
  log ( " \ t - combinar prueba de sujeto y entrenamiento " )
  tema_datos  <- rbind ( prueba_subjeto_datos , tren_subjeto_datos )
  nombres ( tema_datos ) <- c ( " tema " )
  keyColumns  <- unión ( keyColumns , names ( data_subject ))
  rm ( prueba_subjeto_datos )
  rm ( tren_subjeto_datos )
  
  log ( " \ t - combinar prueba de actividad y entrenamiento " )
  datos_y  <- rbind ( datos_y_prueba , datos_y_train )
  nombres ( datos_y ) <- c ( " activity_num " )
  keyColumns  <- unión ( keyColumns , nombres ( data_y ))
  rm ( datos_y_prueba )
  rm ( datos_y_train )
  
  log ( " \ t - combinar prueba de datos de características y entrenamiento " )
  data_x  <- rbind ( data_x_test , data_x_train )
  featuresFile  <- file.path ( extractedZipPath , " features.txt " )
  featureData  <- read.table ( featuresFile )
  featureColumns  <-  featureData $ V2
  nombres ( data_x ) <-  featureColumns
  rm ( datos_x_prueba )
  rm ( data_x_train )
  rm ( featureData )
  
  
  
  # combine los 3 conjuntos de datos como columnas en mergedData
  log ( " \ t - combinar datos de tema, actividad y características " )
  mergedData  <- cbind ( tema_datos , y_datos )
  mergedData  <- cbind ( mergedData , data_x )
  rm ( tema_datos )
  rm ( datos_x )
  rm ( datos_y )
  
  log ( " \ t -` mergedData` cargado en la memoria: " , nrow ( mergedData ), " x " , ncol ( mergedData ))
} más {
  log ( " [# 1] Fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de datos " ).
  log ( " \ t -` mergedData` ya cargado en la memoria: " , nrow ( mergedData ), " x " , ncol ( mergedData ))
}
libro de códigos ( " *` mergedData` cargado en la memoria, dimensiones: " , nrow ( mergedData ), " x " , ncol ( mergedData ))



# 2. Extrae solo las medidas de la media y la desviación estándar de cada medida.

log ( " [# 2] Extrae solo las medidas de la media y la desviación estándar de cada medida " ).
meanStdFeatureColumns  <-  featureColumns [grepl ( " (mean | std) \\ ( \\ ) " , featureColumns )]
subSetColumns  <- unión ( keyColumns , meanStdFeatureColumns )
subSetMergedData  <-  mergedData [, subSetColumns ]
libro de códigos ( " * subconjunto de` mergedData` en `subSetMergedData` manteniendo solo las columnas clave y las características que contienen` std` o `mean`, dimensiones: " , nrow ( subSetMergedData ), " x " , ncol ( subSetMergedData ))


# 3. Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos
log ( " [# 3] Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos " )
activitiesFile  <- file.path ( extraídoZipPath , " activity_labels.txt " )
activitiesData  <- read.table (archivo de actividades )
nombres ( datos_actividades ) <- c ( " núm_actividad " , " nombre_actividad " )

subSetMergedData  <- fusionar ( subSetMergedData , activitiesData , by = " activity_num " , all.x = TRUE )
subSetKeyColumns  <- Unión ( KeyColumns , C ( " ACTIVITY_NAME " ))
libro de códigos ( " * merged` " , activitiesFile , " `contenido con la columna` activity_num` correcta, agregando efectivamente `activity_name` a` subSetMergedData`, dimensiones: " , nrow ( subSetMergedData ), " x " , ncol ( subSetMergedData ))

# 4. Etiquete adecuadamente el conjunto de datos con nombres de variables descriptivos.
log ( " [# 4] Etiqueta adecuadamente el conjunto de datos con nombres de variables descriptivas " ).
reshapedData  <- derretir ( subSetMergedData , subSetKeyColumns )
libro de códigos ( " * funden` subSetMergedData` en `reshapedData`, basado en columnas de clave, dimensiones: " , nrow ( reshapedData ), " x " , NcoI ( reshapedData ))

# dividir la variable en partes (lista de vectores de caracteres) y remodelarla en un marco de datos y agregarla a reshapedData
variableList  <- strsplit (gsub ( " ^ ((f | t) (Body | BodyBody | Gravity) (Gyro | Acc | Body) [ \\ -] * (Jerk)? (Mag)? [ \\ -] * ( significa | estándar) [ \\ ( \\ ) \\ -] * (X | Y | Z)?) " , " \\ 2 | \\ 3 | \\ 4 | \\ 5 | \\ 6 | \\ 7 | \\ 8 | \\ 1 " , reshapedData $ variable ), " \\ | " )
nrows  <- longitud ( variableList )
ncols  <- longitud (unlist ( variableList [ 1 ]))
variableUnlist  <- unlist ( variableList )
variableMatrix  <-  matriz ( variableUnlist , nrow = nrows , ncol = ncols , byrow = TRUE )
variableData  <- como.data.frame ( variableMatrix )
variableData $ V8  <-  NULL
nombres ( variableData ) <- c ( " dimensión " , " fuente " , " tipo " , " tirón " , " magnitud " , " método " , " eje " )
reshapedData  <- cbind ( reshapedData , datos_variable )
rm (lista de variables )
rm ( variableUnlist )
rm (matriz de variables )
rm (datos variables )
libro de códigos ( " columna * dividida característica` variable` en 7 columnas separadas (para cada característica sub), y se añadió a `reshapedData`, dimensiones: " , nrow ( reshapedData ), " x " , NcoI ( reshapedData ))


resultData  <-  reshapedData
rm (datos remodelados )
libro de códigos ( " * renombrado` reshapedData` a ** `resultData` ** " )
log ( " variable` resultData` disponible para su uso: " , nrow ( resultData ), " x " , ncol ( resultData ))


# 5. Crea un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada tema.
log ( " [# 5] Etiqueta adecuadamente el conjunto de datos con nombres de variables descriptivas " ).
tidyData  <- dcast ( resultData , activity_name  +  subject  ~  variable , mean )
log ( " variable` tidyData` disponible para su uso " , nrow ( tidyData ), " x " , ncol ( tidyData ))
libro de códigos ( " * fundir` resultData` en ** `tidyData` ** con el promedio de cada variable para cada actividad y las dimensiones de cada tema: " , nrow ( tidyData ), " x " , ncol ( tidyData ))

log ( " Escribiendo` tidyData` en ` " , targetResultFilePath , " ` " )
libro de códigos ( " * escribir` tidyData` en el archivo ` " , targetResultFilePath , " ` " )
write.table ( tidyData , targetResultFilePath , row.names  =  FALSE , quote  =  FALSE , col.names  =  TRUE )



# escribir propiedades de variables
libro de códigos ( " " )
libro de códigos ( " ##` resultData` variable \ n " )
libro de códigos ( " ### columnas clave \ n " )
libro de códigos ( " Nombre de variable | Descripción " )
libro de códigos ( " -------------------- | ------------ " )
libro de códigos ( " ` asunto` | ID del asunto, int (1-30) " )
libro de códigos ( " ` activity_num` | ID de la actividad, int (1-6) " )
libro de códigos ( " ` nombre_actividad` | Etiqueta de la actividad, factor con 6 niveles " )

libro de códigos ( " ### columnas sin clave \ n " )
libro de códigos ( " Nombre de variable | Descripción " )
libro de códigos ( " -------------------- | ------------ " )
libro de códigos ( " ` variable` | nombre completo de la función, factor con 66 niveles (p. ej. tBodyAcc-mean () - X) " )
libro de códigos ( " ` valor` | el valor real, num (rango: -1: 1) " )
libro de códigos ( " ` dimensión` | dimensión de medida, Factor con 2 niveles: `t` (Tiempo) o` f` (Frecuencia) " )
libro de códigos ( " ` fuente` | fuente de medición, Factor con 3 niveles: `Cuerpo`,` BodyBody` o `Gravity` " )
libro de códigos ( " ` tipo` | tipo de medición, Factor con 2 niveles: `Acc` (acelerómetro) o` Gyro` (giroscopio) " )
libro de códigos ( " ` Jerk` | es la señal de 'Jerk', Factor con 2 niveles: `Jerk` o` (no Jerk) " )
libro de códigos ( " ` magnitud` | es el valor de 'Magnitud', Factor con 2 niveles: `Mag` o` (no Mag) " )
libro de códigos ( " ` método` | resultado del método, Factor w / 2 niveles: `mean` (promedio) o` std` (desviación estándar) " )
libro de códigos ( " ` eje` | FFT exrapolado al eje, factor con 2 niveles: `` (sin eje FFT) o `X`,` Y` o `Z` " )

libro de códigos ( " " )
libro de códigos ( " ##` tidyData` variable \ n " )
libro de códigos ( " ### columnas clave \ n " )
libro de códigos ( " Nombre de variable | Descripción " )
libro de códigos ( " -------------------- | ------------ " )
libro de códigos ( " ` nombre_actividad` | Etiqueta de la actividad, factor con 6 niveles " )
libro de códigos ( " ` asunto` | ID del asunto, int (1-30) " )


libro de códigos ( " ### columnas sin clave \ n " )
libro de códigos ( " Nombre de variable | Descripción " )
libro de códigos ( " -------------------- | ------------ " )
tidyDataCols  <- nombres ( tidyData ) [ 3 : 68 ]
para ( tdc  en  tidyDataCols ) {
  libro de códigos ( " ` " , tdc , " `| el valor promedio para esta característica, num (rango: -1: 1) " )
}
