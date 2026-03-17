#!/bin/bash

BASE=~/tp_intro
ENTRADA=$BASE/entrada
SALIDA=$BASE/salida
PROCESADO=$BASE/procesado
ARCHIVO=$SALIDA/$FILENAME.txt

# Validar variable de entorno
if [ -z "$FILENAME" ]; then
  echo "Error: definir variable de entorno FILENAME"
  exit 1
fi

# Opción -d
if [ "$1" == "-d" ]; then
  pkill -f consolidar.sh
  rm -rf "$BASE"
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
      pgrep -f consolidar.sh > /dev/null || bash "$BASE/consolidar.sh" &
      echo "Proceso corriendo..."
      ;;

    3)
      if [ -f "$ARCHIVO" ]; then
        sort -n "$ARCHIVO"
      else
        echo "No hay datos"
      fi
      ;;

    4)
      if [ -f "$ARCHIVO" ]; then
        sort -k5 -nr "$ARCHIVO" | head -10
      else
        echo "No hay datos"
      fi
      ;;

    5)
      if [ -f "$ARCHIVO" ]; then
        echo "Ingrese padrón:"
        read padron
        grep "^$padron" "$ARCHIVO"
      else
        echo "No hay datos"
      fi
      ;;

    6)
      exit
      ;;

    *)
      echo "Opción inválida"
      ;;

  esac
done
