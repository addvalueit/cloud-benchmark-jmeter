FROM java:8

ENV     	DEBIAN_FRONTEND noninteractive

ENV		JMETER_VERSION	2.13
ENV		JMETER_HOME	/opt/jmeter
ENV		JMETER_DOWNLOAD_URL  http://mirror.serversupportforum.de/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.zip
ENV		NUMERO_ESECUZIONE  1
ENV		NUMERO_THREAD  1
ENV		DELAY_ORDINI_MIN  1
ENV		DELAY_ORDINI_MAX  1
ENV		TEMPO_AVVIO  1
ENV		RUN_REGISTRAZIONE  true
ENV		RUN_ORDINI  true

# install needed debian packages & clean up
RUN		apt-get update && \
		apt-get install -y --no-install-recommends curl tar ca-certificates unzip && \
		apt-get clean autoclean && \
        	apt-get autoremove --yes && \
        	rm -rf /var/lib/{apt,dpkg,cache,log}/

# download and extract jmeter 
RUN		mkdir -p ${JMETER_HOME} \
 		curl -L --silent ${JMETER_DOWNLOAD_URL} \
        unzip ${JMETER_HOME} \
 		curl -L --silent http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.2.1.zip -o /tmp/jmeter-plugins-standard.zip \
 		unzip -o -d /opt/jmeter/ /tmp/jmeter-plugins-standard.zip \
 		rm /tmp/jmeter-plugins-standard.zip \

WORKDIR		${JMETER_HOME}

ADD cloud-benchmark.jmx ${JMETER_HOME}/cloud-benchmark.jmx
ADD registrazioneUtente.csv ${JMETER_HOME}/registrazioneUtente.csv

CMD ["bin/jmeter -n -t ${JMETER_HOME}/cloud-benchmark.jmx -JdirectoryCsv=registrazioneUtente.csv -JnumeroEsecuzione=${NUMERO_ESECUZIONE} -JnumeroThread=${NUMERO_THREAD} -JtempoDiAttesaOrdiniMin=${DELAY_ORDINI_MIN} -JtempoDiAttesaOrdiniMax=${DELAY_ORDINI_MAX} -JtempoDiAvvio=${TEMPO_AVVIO} -JrunRegistrazioneUtenti=${RUN_REGISTRAZIONE} -JrunInserisciOrdine=${RUN_ORDINI}"]
