# Subscribe to 1 topic
df = spark \
  .readStream \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "localhost:2181") \
  .option("subscribe", "input") \
  .load()
df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)")

df = spark \
  .read \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "localhost:2181") \
  .option("subscribe", "input") \
  .load()
df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)")
