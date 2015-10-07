#!/bin/bash
c=${NUMERO_ESECUZIONE}
max=$((c+REPEAT))
while [[ $c -lt $max ]]; do

	echo "running #" $c

	JVM_ARGS=${JMETER_JVM_ARGS} \
	bin/jmeter -n -t CloudBenchmark.jmx \
	-JdirectoryCsv=registrazioneUtente.csv \
	-JserverName=${SERVER_NAME} \
	-JserverPort=${SERVER_PORT} \
	-JnumeroEsecuzione=$c \
	-JnumeroThread=${NUMERO_THREAD} \
	-JtempoDiAttesaOrdiniMin=${DELAY_ORDINI_MIN} \
	-JtempoDiAttesaOrdiniMax=${DELAY_ORDINI_MAX} \
	-JtempoDiAvvio=${TEMPO_AVVIO} \
	-JrunRegistrazioneUtenti=${RUN_REGISTRAZIONE} \
	-JrunInserisciOrdine=${RUN_ORDINI} \
	-JrunQuerySuiTuoiDatiCompleta=${QUERY_COMPLETA} \
	-JrunQuerySuiTuoiDatiEnqueue=${QUERY_IN_CODA} 
	
	(( c++ ))
done

echo "running completed" 

