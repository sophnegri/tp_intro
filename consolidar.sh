#!/bin/bash

BASE=~/EPNro1
ENTRADA=$BASE/entrada
SALIDA=$BASE/salida
PROCESADO=$BASE/procesado

# Validar variable de entorno
if [ -z "$FILENAME" ]; then
  echo "Error: definir variable de entorno FILENAME"
  exit 1
fi

ARCHIVO=$SALIDA/$FILENAME.txt

touch "$ARCHIVO"

while true; do
  for f in "$ENTRADA"/*.txt; do

    [ -e "$f" ] || continue

    cat "$f" >> "$ARCHIVO"
    mv "$f" "$PROCESADO"

    echo "Procesado: $f"

  done

  sleep 5
done
