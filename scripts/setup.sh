#! /bin/bash

#=========================#
# Hostname retrieval and renaming script
# J.Hunt (2023)
# Req:  Run as root or SU
# Req:  a hostdb comma-delimited file
#   hostdb headers: MAC_ADDR,Client_ID,IP_ADDR,HOSTNAME,DESCR
#   Example: 2e:5d:27:39:1f:9b,node1,192.168.10.51,node1,Node1's Desc
#=========================#

#=========================#
# BEGIN #
#=========================#
# Gather IP and MAC Addr from ip binary
IPADDR=$(ip a|grep /24| awk '{print $2}'| cut -d"/" -f 1)
MACADDR=$(ip a|grep ether| awk '{print $2}')
# point to a hostdb file in home directory
HOSTDB=/home/$USER/hostdb

echo "#=========================#"
echo "Current Configurations:"
echo "#=========================#"
echo "IP Address: $IPADDR"
echo "MAC Address: $MACADDR"
echo "#=========================# \n"
echo "Checking to see if HostnameDB exists..."

# Checking to see if HostDB file exists...
if test -f $HOSTDB; then
    # Found the hostdb file and pulling the hostname
    # assumes proper formatting and records hostname to var
    echo "Found hostdb"
    HOSTNM=$(cat hostdb| grep $MACADDR | cut -d"," -f 4)
    echo "FOund MAC address in hostdb:" $HOSTNM
    echo $HOSTNM
    # Resetting hostname
    $(hostnamectl hostname $HOSTNM)
fi
#@TODO cleanup hostdb file
#@TODO remediation if hostdb file isnt found.