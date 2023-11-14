#!/usr/bin/bash

function Utilization {
        Periodos=$( ls -l ./MXPTLM01SPGW01_bulkstats_20230730_12-14/*.csv | awk '{print $9}')
        for cadaarchivo in $Periodos
        do
                printf "\nEquipo: "$cadaarchivo
                echo ""
                DateTime=$( echo $cadaarchivo| awk -F_ '{print $6"_"$7}')
                card=$( grep -w 'cardSch1'   $cadaarchivo| awk -F, '{print "|__"$8 "__|"}')
                memused=$( grep -w 'cardSch1'   $cadaarchivo| awk -F, '{print $12}')
                memtotal=$( grep -w 'cardSch1'   $cadaarchivo| awk -F, '{print $13}')
		memutilcero=$( grep -w 'cardSch1'   $cadaarchivo| awk -F, '{print "|" ($12)/($13+1) "|"}')
		echo "************************************************************$DateTime************************************************************" >> ./reporte.log
                        for Kard in $cadaarchivo
                        do
                        echo $card >> ./reporte.log
			if [ "$memtotal" == "0" ] && [ "$memused" == "0" ];
					then
                                	echo "0" >> ./reporte.log
                                else
                                	for memUsed in $cadaarchivo
                                	do
                                	echo $memutilcero >> ./reporte.log
                                	done
				
                                fi
				echo \ >> ./reporte.log

		        done
        done

}

Utilization

#######edservin
