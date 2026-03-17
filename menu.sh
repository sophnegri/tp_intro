#!/bin/bash

BASE=~/EPNro1
ENTRADA=$BASE/entrada
SALIDA=$BASE/salida
PROCESADO=$BASE/procesado
ARCHIVO=$SALIDA/$FILENAME.txt

# Validar variable
if [ -z "$FILENAME" ]; then
  echo "Error: definir variable de entorno FILENAME"
  exit 1
fi

# Opción -d
if [ "$1" == "-d" ]; then
  rm -rf $BASE
  pkill -f consolidar.sh
  echo "Todo borrado"
  exit
fi

while true; do
  echo "1 Crear entorno"
  echo "2 Correr proceso"
  echo "3 Listar alumnos"
  echo "4 Top 10 notas"
  echo "5 Buscar alumno"
  echo "6 Salir"

  read op

  case $op in

    1)
      mkdir -p "$ENTRADA" "$SALIDA" "$PROCESADO"
      echo "Entorno creado"
      ;;

    2)
      pgrep -f consolidar.sh > /dev/null || bash $BASE/consolidar.sh &
      echo "Proceso corriendo..."
      ;;

    3)
      [ -f "$ARCHIVO" ] || { echo "No hay datos"; continue; }
      sort -n "$ARCHIVO"
      ;;

    4)
      [ -f "$ARCHIVO" ] || { echo "No hay datos"; continue; }
      sort -k4 -nr "$ARCHIVO" | head -10
      ;;

    5)
      [ -f "$ARCHIVO" ] || { echo "No hay datos"; continue; }
      echo "Ingrese padrón:"
      read padron
      grep "^$padron" "$ARCHIVO"
      ;;

    6)
      exit
      ;;

    *)
      echo "Opción inválida"
      ;;

  esac
done
