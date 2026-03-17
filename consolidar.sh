#!/bin/bash

BASE=~/EPNro1
ENTRADA=$BASE/entrada
SALIDA=$BASE/salida
PROCESADO=$BASE/procesado
ARCHIVO=$SALIDA/$FILENAME.txt

while true; do
  for f in $ENTRADA/*.txt; do

    [ -e "$f" ] || continue

    cat $f >> $ARCHIVO
    mv $f $PROCESADO

  done

  sleep 5
done
