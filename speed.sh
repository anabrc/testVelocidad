#!/bin/bash
# Departamento de soporte N2
# Autora: abramirez
# Fecha: 12/02/2021
# Version: 1.2

# Desclaración de variables

lent="0"

# Declaración de funciones para la lentitud en la bajada y en la subida

function descarga ()
{
    descarga=$(cat /tmp/speed.txt | grep -i Download: | awk -F: '{print $2}' | awk '{print $1}' | awk -F. '{print $1}')

    if [ $descarga -lt 90 ]; then
        echo "FAIL - Test velocidad en la descarga."
        lent="1"
    else
        echo "OK - Test velocidad en la descarga."
    fi

}

function subida ()
{
    subida=$(cat /tmp/speed.txt | grep -i Upload: | awk -F: '{print $2}' | awk '{print $1}' | awk -F. '{print $1}')

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
        # Eliminamos el fichero
        rm /tmp/speed.txt
        exit 0
    else
        # Eliminamos el fichero
        rm /tmp/speed.txt
        exit 2
    fi
}

# Creamos el fichero con el test de velocidad

speedtest-cli > /tmp/speed.txt

# Llamamos a las funciones

descarga
subida
comprobacion








