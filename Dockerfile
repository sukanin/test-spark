from gcr.io/datamechanics/spark:2.4-latest
USER root
ENV PYSPARK_MAJOR_PYTHON_VERSION=3
WORKDIR /opt/application/

RUN apt-get update && apt-get install gcc g++ -y

RUN wget  https://jdbc.postgresql.org/download/postgresql-42.2.5.jar
RUN mv postgresql-42.2.5.jar /opt/spark/jars

COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

COPY main.py .