#!/bin/bash
# Script para comprobar la conexión a Internet de un servidor, o cualquier equipo Linux
# Departamento de soporte N2
# Autora: abramirez
# Fecha: 12/02/2021
# Version: 2.0

# Desclaración de variables

lent="0"

# Declaración de funciones para la lentitud en la bajada y en la subida

function descarga ()
{
    descarga=$(cat /root/speed.txt | grep -i Download: | awk -F: '{print $2}' | awk '{print $1}' | awk -F. '{print $1}')

    if [ $descarga -lt 90 ]; then
        echo "FAIL - Test velocidad en la descarga."
        lent="1"
    else
        echo "OK - Test velocidad en la descarga."
    fi

}

function subida ()
{
    subida=$(cat /root/speed.txt | grep -i Upload: | awk -F: '{print $2}' | awk '{print $1}' | awk -F. '{print $1}')

    if [ $subida -lt 90 ]; then
        echo "FAIL - Test velocidad en la subida."
        lent="1"
    else
        echo "OK - Test velocidad en la subida."
    fi

}

function comprobacion ()
{
    if [ "$lent" == "0" ]; then
        exit 0
    else
        exit 2
    fi
}

# Comprobamos que el fichero existe

if [ -f /root/speed.txt ]; then
        # Si el fichero existe, comenzamos las comprobaciones
        descarga
        subida
        comprobacion
else
        # Si el fichero no existe, mostrará un warning
        echo "El fichero NO existe"
        exit 1
fi
