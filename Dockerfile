from gcr.io/datamechanics/spark:2.4-latest
USER root
ENV PYSPARK_MAJOR_PYTHON_VERSION=3
WORKDIR /opt/application/

RUN apt-get update && apt-get install gcc g++ -y

RUN wget  https://jdbc.postgresql.org/download/postgresql-42.2.5.jar
RUN mv postgresql-42.2.5.jar /opt/spark/jars

RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-streaming-kafka-0-8-assembly_2.11/2.2.0/spark-streaming-kafka-0-8-assembly_2.11-2.2.0.jar
RUN mv spark-streaming-kafka-0-8-assembly_2.11-2.2.0.jar /opt/spark/jars

RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-sql_2.11/2.2.0/spark-sql_2.11-2.2.0.jar
RUN mv spark-sql_2.11-2.2.0.jar /opt/spark/jars

COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

COPY main.py .