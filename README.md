# Prueba-final-
prueba final 
Proyecto de obtención y limpieza de datos de Coursera
https://www.coursera.org/course/getdata

El propósito de este proyecto es demostrar su capacidad para recopilar, trabajar y limpiar un conjunto de datos. El objetivo es preparar datos ordenados que se puedan utilizar para un análisis posterior. Sus compañeros lo calificarán en una serie de preguntas de sí / no relacionadas con el proyecto. Se le pedirá que envíe: 1) un conjunto de datos ordenado como se describe a continuación, 2) un enlace a un repositorio de Github con su script para realizar el análisis y 3) un libro de códigos que describe las variables, los datos y cualquier transformación o trabajo que realizó para limpiar los datos llamado CodeBook.md. También debe incluir un README.md en el repositorio con sus scripts. Este repositorio explica cómo funcionan todos los scripts y cómo están conectados.

Una de las áreas más interesantes de toda la ciencia de datos en este momento es la informática portátil; consulte, por ejemplo, este artículo. Empresas como Fitbit, Nike y Jawbone Up están compitiendo para desarrollar los algoritmos más avanzados para atraer nuevos usuarios. Los datos vinculados desde el sitio web del curso representan datos recopilados de los acelerómetros del teléfono inteligente Samsung Galaxy S. Una descripción completa está disponible en el sitio donde se obtuvieron los datos:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Aquí están los datos del proyecto:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Debe crear un script de R llamado run_analysis.R que haga lo siguiente.

Fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de datos.
Extrae solo las medidas de la desviación media y estándar de cada medida.
Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos
Etiqueta adecuadamente el conjunto de datos con nombres de variables descriptivas.
Crea un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada tema.
Ejecutando
instalar paquetes
RCurl
remodelar2
establecer dir de trabajo
Script crea un ./datadirectorio relativo en el que descarga el .zip, lo extrae y escribe el archivo de resultado ( tidy_data.txt)
correr run_analysis.R
escribe datos en el ./datadirectorio
genera / sobrescribe ./CodeBook.md
source('run_analysis.R')
variables globales tidyData& resultData(ver CodeBook.md)
