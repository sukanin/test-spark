IMAGE_NAME=pyspark-example:dev

# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(IMAGE_NAME) .

build-nc: ## Build the container without caching
	docker build --no-cache -t $(IMAGE_NAME) .

run: ## Build the container without caching
	docker run --mount type=bind,source=$(CURDIR),target=/opt/application $(IMAGE_NAME) driver local:///opt/application/main.py -iz localhost:2181 -it input -oz localhost:2181 -ot output

shell: ## Build the container without caching
	docker run -it --network kafka-docker_default $(IMAGE_NAME) /opt/spark/bin/pyspark \
		--packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.2.0,org.apache.spark:spark-core_2.12:3.2.0,org.apache.spark:spark-sql_2.12:3.2.0,org.apache.spark:spark-streaming_2.12:3.2.0,org.apache.spark:spark-streaming-kafka-0-10_2.12:3.2.0
