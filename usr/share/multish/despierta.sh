#!/bin/bash
# despierta.sh
# Victor Martinez Pajares
# Envia una señal wakeonlan a un equipo según su nombre
# Se puede hacer con etherwake, pero obliga a generar un fichero de macs-name y es un rollo.

if [ "$#" -ne 1 ]; then
    echo "Send a wakeonlan magic packet to a hostname"
    echo "Use: $0 hostname"
    exit
fi

# Search in group 1
echo "Searching $1 in group 1."
SEARCH=`ldapsearch -xLLL -h ldap -b  cn=$1,cn=group1,cn=INTERNAL,cn=DHCP\ Config,dc=instituto,dc=extremadura,dc=es "dhcpHWAddress" 2> /dev/null`

# If fails, search in group 2
if [ "$?" -ne 0 ]; then
echo "Can't find $1 in the group 1."
echo "Searching $1 in group 2."
    SEARCH=`ldapsearch -xLLL -h ldap -b  cn=$1,cn=group2,cn=INTERNAL,cn=DHCP\ Config,dc=instituto,dc=extremadura,dc=es "dhcpHWAddress" 2> /dev/null`
fi

# If can't find, exit
if [ "$?" -ne 0 ]; then
    echo "Can't find the hostname $1."
    echo "No WakeOnLAN package was sended to the net."
    exit
fi

MAC=`echo $SEARCH | grep -o '[^ ]*$'`

echo "Sending WakeOnLan package to $1 with MAC: $MAC"
wakeonlan $MAC