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
	docker run -it $(IMAGE_NAME) /opt/spark/bin/pyspark --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.4.7

