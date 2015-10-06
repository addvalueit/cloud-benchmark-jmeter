FROM hauptmedia/jmeter

ENV    JMETER_JVM_ARGS "-Xms512m -Xmx2g"
ENV    JMETER_HOME /opt/jmeter
ENV    NUMERO_ESECUZIONE 1
ENV    SERVER_NAME 172.31.2.92
ENV    SERVER_PORT 9100
ENV    NUMERO_THREAD 500
ENV    DELAY_ORDINI_MIN 1
ENV    DELAY_ORDINI_MAX 1
ENV    TEMPO_AVVIO 1
ENV    RUN_REGISTRAZIONE true
ENV    RUN_ORDINI true
ENV    REPEAT 250

WORKDIR    ${JMETER_HOME}

ADD CloudBenchmark.jmx ${JMETER_HOME}/CloudBenchmark.jmx
ADD registrazioneUtente.csv ${JMETER_HOME}/registrazioneUtente.csv
ADD scriptJMeter.sh ${JMETER_HOME}/scriptJMeter.sh
RUN chmod +x ${JMETER_HOME}/scriptJMeter.sh

ENTRYPOINT ["./scriptJMeter.sh"]
