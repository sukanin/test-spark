from gcr.io/datamechanics/spark:3.2.0-latest
USER root
ENV PYSPARK_MAJOR_PYTHON_VERSION=3
WORKDIR /opt/application/

from gcr.io/datamechanics/spark:3.2.0-latest
USER root
ENV PYSPARK_MAJOR_PYTHON_VERSION=3
WORKDIR /opt/application/

RUN apt-get update && apt-get install gcc g++ -y

RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_2.12/3.2.0/spark-sql-kafka-0-10_2.12-3.2.0.jar
RUN mv spark-sql-kafka-0-10_2.12-3.2.0.jar /opt/spark/jars

COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-core_2.12/3.2.0/spark-core_2.12-3.2.0.jar
RUN mv spark-core_2.12-3.2.0.jar /opt/spark/jars

RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-sql_2.12/3.2.0/spark-sql_2.12-3.2.0.jar
RUN mv spark-sql_2.12-3.2.0.jar /opt/spark/jars

RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-streaming_2.12/3.2.0/spark-streaming_2.12-3.2.0.jar
RUN mv spark-streaming_2.12-3.2.0.jar /opt/spark/jars

RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-mllib_2.12/3.2.0/spark-mllib_2.12-3.2.0.jar
RUN mv spark-mllib_2.12-3.2.0.jar /opt/spark/jars

RUN wget https://repo1.maven.org/maven2/org/apache/spark/spark-streaming-kafka-0-10_2.12/3.2.0/spark-streaming-kafka-0-10_2.12-3.2.0.jar
RUN mv spark-streaming-kafka-0-10_2.12-3.2.0.jar /opt/spark/jars

COPY main.py .