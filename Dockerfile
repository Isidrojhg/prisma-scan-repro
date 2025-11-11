FROM redhat/ubi9:latest

RUN groupadd -r myuser && useradd -r -u 1001 -g myuser myuser

RUN mkdir -p /app/data && \
    chmod 700 /app/data && \
    chown myuser:myuser /app/data

USER myuser

WORKDIR /app/data

ADD *.jar /app/data
