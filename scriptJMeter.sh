#!/bin/bash
c=${NUMERO_ESECUZIONE}
max=$((${REPEAT} + ${NUMERO_ESECUZIONE}))
while [[ $c -lt $max ]]; do

	echo "running #" $c

	JVM_ARGS=${JMETER_JVM_ARGS} \
	bin/jmeter -n -t ${JMETER_HOME}/CloudBenchmark.jmx \
	-JdirectoryCsv=registrazioneUtente.csv \
	-JserverName=${SERVER_NAME} \
	-JserverPort=${SERVER_PORT} \
	-JnumeroEsecuzione=${NUMERO_ESECUZIONE} \
	-JnumeroThread=${NUMERO_THREAD} \
	-JtempoDiAttesaOrdiniMin=${DELAY_ORDINI_MIN} \
	-JtempoDiAttesaOrdiniMax=${DELAY_ORDINI_MAX} \
	-JtempoDiAvvio=${TEMPO_AVVIO} \
	-JrunRegistrazioneUtenti=${RUN_REGISTRAZIONE} \
	-JrunInserisciOrdine=${RUN_ORDINI}
	
	(( c++ ))
done

echo "running completed" 

