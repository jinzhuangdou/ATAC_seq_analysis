
#!/bin/sh
mkdir jobs 
mkdir log
while IFS="," read -r id r1 r2 r3 r4; do
        #echo $id" " $normal" "$tumor
        echo ${id}
	echo $r1
	echo $r2
	echo $r3
	echo $r4
        sed "s/samplename/${id}/g" temp1  |   sed -e "s/PROJECT_IN/PL-CAR-NK_PM1844/g"  |    sed -e "s/PROJECT/PE_EXP/g"  |  sed -e "s/FLAG1/${r1}/g" | sed -e "s/FLAG2/${r2}/g"  | sed -e  "s/FLAG3/${r3}/g" | sed "s/FLAG4/${r4}/g"  > "jobs/${id}"
	bsub <  ./jobs/${id} & 
  
done < sampleLst1



while IFS="," read -r id r1 r2 r3 r4; do
        #echo $id" " $normal" "$tumor
        echo ${id}
        echo $r1
        echo $r2
        echo $r3
        echo $r4
        sed "s/samplename/${id}/g" temp1  |  sed -e "s/PROJECT_IN/PL-CAR-NK_PM1844-2/g" |  sed -e "s/PROJECT/PE_EXP/g"  |   sed -e "s/FLAG1/${r1}/g" | sed -e "s/FLAG2/${r2}/g"  | sed -e  "s/FLAG3/${r3}/g" | sed "s/FLAG4/${r4}/g"  > "jobs/${id}"
        #bsub <  ./jobs/${id} &

done < sampleLst2

