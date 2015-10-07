FROM hauptmedia/jmeter

ENV JMETER_JVM_ARGS    "-Xms512m -Xmx2g" \
    JMETER_HOME        /opt/jmeter       \
    NUMERO_ESECUZIONE  1                 \
    SERVER_NAME        172.31.2.92       \
    SERVER_PORT        9100              \
    NUMERO_THREAD      500               \
    DELAY_ORDINI_MIN   2500              \
    DELAY_ORDINI_MAX   2500              \
    TEMPO_AVVIO        1                 \
    RUN_REGISTRAZIONE  true              \
    RUN_ORDINI         true              \
    REPEAT             250               

WORKDIR    ${JMETER_HOME}

ADD CloudBenchmark.jmx ${JMETER_HOME}/CloudBenchmark.jmx
ADD registrazioneUtente.csv ${JMETER_HOME}/registrazioneUtente.csv
ADD scriptJMeter.sh ${JMETER_HOME}/scriptJMeter.sh
RUN chmod +x ${JMETER_HOME}/scriptJMeter.sh

ENTRYPOINT ["./scriptJMeter.sh"]
