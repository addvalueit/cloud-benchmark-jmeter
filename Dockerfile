FROM hauptmedia/jmeter

ENV		NUMERO_ESECUZIONE  1
ENV		NUMERO_THREAD  1
ENV		DELAY_ORDINI_MIN  1
ENV		DELAY_ORDINI_MAX  1
ENV		TEMPO_AVVIO  1
ENV		RUN_REGISTRAZIONE  true
ENV		RUN_ORDINI  true


ADD CloudBenchmark.jmx cloud-benchmark.jmx
ADD registrazioneUtente.csv registrazioneUtente.csv

ENTRYPOINT ["bin/jmeter"]
CMD ["-n", "-t", "cloud-benchmark.jmx", "-JdirectoryCsv=registrazioneUtente.csv", "-JnumeroEsecuzione=${NUMERO_ESECUZIONE}", "-JnumeroThread=${NUMERO_THREAD}", "-JtempoDiAttesaOrdiniMin=${DELAY_ORDINI_MIN}", "-JtempoDiAttesaOrdiniMax=${DELAY_ORDINI_MAX}", "-JtempoDiAvvio=${TEMPO_AVVIO}", "-JrunRegistrazioneUtenti=${RUN_REGISTRAZIONE}", "-JrunInserisciOrdine=${RUN_ORDINI}"]
