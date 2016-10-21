#!/bin/bash

echo "deb http://httpredir.debian.org/debian wheezy-backports main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://httpredir.debian.org/debian wheezy-backports main contrib non-free" >> /etc/apt/sources.list

apt-get update && apt-get -t wheezy-backports install -y ansible

brctl addbr br0
read -p "Lancer tous les périphériques de Marionnet et appuyer sur entrer" pause

brctl addbr br1
brctl addbr br2
brctl addbr br3

liste=$(brctl show | grep -o "sktap[0-9]*")
occupation_bridge=("0" "0" "0" "0")

for interface in $liste 
do
	echo "Traitement de l'interface $interface"
	old_bridge="br0"
	for bridge in br3 br2 br1 br0
	do			
		case "$bridge" in
			"br0") 
				i=0				
				reseau="10.224.32.10/24"
				ipR1="10.224.32.1" 
				;;
			"br1") 
				i=1
				reseau="10.224.64.10/24"
				ipR1="10.224.64.1" 
				;;
			"br2")
				i=2
				reseau="10.224.96.10/24"
				ipR1="10.224.96.1"
				;;
			"br3") 
				i=3
				reseau="10.224.33.10/24"
				ipR1="10.224.33.1"
				;;
		esac

		if [ ${occupation_bridge[$i]} != 0 ]
		then 
			continue
		fi

		echo "--- Ping : $ipR1"

		brctl delif $old_bridge $interface
		brctl addif $bridge $interface
		ifconfig $bridge $reseau
		ping -I $bridge -c 1 $ipR1 >> /dev/null
		if [ $? -eq 0 ] 
		then
			echo "=> $bridge : $reseau"
			occupation_bridge[$i]=1
			echo "Avancement :" ${occupation_bridge[@]}
			break
		fi
		
		old_bridge=$bridge
		
	done
		
done

echo "Configuration terminée"
