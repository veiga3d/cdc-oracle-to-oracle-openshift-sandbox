#!/bin/bash

# Inicia o Kafka Connect em background
/kafka/bin/connect-distributed.sh /kafka/config/connect-distributed.properties &

# Aguarda Kafka Connect REST API subir
echo "Aguardando Kafka Connect REST API subir..."
until curl -s http://localhost:8083/connectors; do
  sleep 5
  echo "Aguardando..."
done

echo "Kafka Connect está pronto. Deploy dos connectors..."

# Faz o deploy dos arquivos JSON dos connectors
for connector in /kafka/connectors/*.json; do
  echo "Deploying $connector"
  curl -X POST -H "Content-Type: application/json" --data @"$connector" http://localhost:8083/connectors || \
  echo "O connector $connector já existe. Ignorando erro."
done

wait -n
exit $?
