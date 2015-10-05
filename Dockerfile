FROM java:8

ENV     	DEBIAN_FRONTEND noninteractive

ENV		JMETER_VERSION	2.13
ENV		JMETER_HOME	/opt/jmeter
ENV		JMETER_DOWNLOAD_URL  http://mirror.serversupportforum.de/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.zip
ENV		NUMERO_ESECUZIONE  1
ENV		SERVER_NAME  172.31.2.92
ENV		SERVER_PORT  9100
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
RUN		mkdir -p ${JMETER_HOME} && \
		curl -L --silent ${JMETER_DOWNLOAD_URL} | unzip && \
		curl -L --silent http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.2.1.zip -o /tmp/jmeter-plugins-standard.zip && \
		unzip -o -d /opt/jmeter/ /tmp/jmeter-plugins-standard.zip && \
		rm /tmp/jmeter-plugins-standard.zip

WORKDIR		${JMETER_HOME}

ADD CloudBenchmark.jmx ${JMETER_HOME}/CloudBenchmark.jmx
ADD registrazioneUtente.csv ${JMETER_HOME}/registrazioneUtente.csv

# Add our crontab file
ADD crontab.txt /config/crontab.txt
ADD cronjob.txt /config/cronjob.txt

#Use the crontab file
RUN crontab /config/crontab.txt

# Start cron
RUN cron
