#!/bin/bash

# Execute options
ARGS=$(getopt -o "hp:n:c:r:wsudx" -l "node" -n "diag.sh" -- "$@");

eval set -- "$ARGS";

while true; do
    case "$1" in
        -n|--node)
            shift;
                    if [ -n "$1" ];
                    then
                        node="$1";
                        shift;
					else
						node="all"
						shift;
                    fi
            ;;
        --)
            shift;
            break;
            ;;
    esac
done

if [ "$node" = "all" ];
then
	count=$(ls /etc/masternodes/ | grep -c methuselah)

	for NUM in $(seq 1 ${count}); do
		echo "****************************************************${NUM} GET INFO************************************************************************"
		methuselah-cli -conf=/etc/masternodes/methuselah_n${NUM}.conf -datadir=/var/lib/masternodes/methuselah${NUM} getinfo
		echo "====================================================${NUM} MN DEBUG========================================================================"
		methuselah-cli -conf=/etc/masternodes/methuselah_n${NUM}.conf -datadir=/var/lib/masternodes/methuselah${NUM} masternode debug
	done
else
		echo "****************************************************${node} GET INFO************************************************************************"
		methuselah-cli -conf=/etc/masternodes/methuselah_n${node}.conf -datadir=/var/lib/masternodes/methuselah${node} getinfo
		echo "====================================================${node} MN DEBUG========================================================================"
		methuselah-cli -conf=/etc/masternodes/methuselah_n${node}.conf -datadir=/var/lib/masternodes/methuselah${node} masternode debug
fi
