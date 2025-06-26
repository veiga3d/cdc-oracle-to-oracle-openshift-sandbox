FROM confluentinc/cp-kafka-connect:7.6.0

USER root
COPY jars /usr/share/java/kafka-connect-jars
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER appuser

ENTRYPOINT ["/entrypoint.sh"]
