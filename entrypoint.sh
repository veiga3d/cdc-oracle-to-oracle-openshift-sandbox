#!/bin/bash
echo ">> Esperando Kafka Connect subir..."
sleep 10

for file in /connectors/*.json; do
  echo ">> Registrando connector: $file"
  curl -X POST -H "Content-Type: application/json" --data @"$file" http://localhost:8083/connectors
done

# Executa o processo principal do Kafka Connect
/etc/confluent/docker/run &
child=$!
wait "$child"
