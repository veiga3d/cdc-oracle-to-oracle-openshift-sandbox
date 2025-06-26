FROM quay.io/debezium/connect:2.4

USER root

# Instalar unzip
RUN microdnf install -y unzip && microdnf clean all

# Diretório dos conectores
ENV KAFKA_CONNECT_PLUGIN_PATH=/kafka/connect:/kafka/connect/debezium-connector-oracle:/kafka/connect/jdbc


# Cria diretório para os arquivos JSON dos connectors
RUN mkdir -p /kafka/connect/jdbc/

# Copia o driver JDBC do Oracle
COPY ./jars/ojdbc8.jar /kafka/connect/jdbc/
COPY ./jars/ojdbc8.jar /kafka/connect/debezium-connector-oracle/
COPY ./jars/ /kafka/connect/jdbc/

RUN mkdir -p /kafka/connect/debezium-oracle/

# Cria diretório dos connectors (source/sink JSONs)
RUN mkdir -p /kafka/connectors

# Copia os arquivos de configuração dos connectors
COPY ./connectors /kafka/connectors/

# Copia o arquivo de configuração connect-distributed.properties
COPY connect-distributed.properties /kafka/config/

COPY connect-log4j.properties /kafka/config/


# Copia o entrypoint customizado
COPY --chmod=755 entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER 1001

ENTRYPOINT ["/entrypoint.sh"]
