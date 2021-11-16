from gcr.io/datamechanics/spark:platform-3.1-dm14
USER root
ENV PYSPARK_MAJOR_PYTHON_VERSION=3
WORKDIR /opt/application/

RUN apk update && apk add python3-dev \
                        gcc \
                        libc-dev

RUN wget  https://jdbc.postgresql.org/download/postgresql-42.2.5.jar
RUN mv postgresql-42.2.5.jar /opt/spark/jars

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY main.py .