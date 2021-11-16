import argparse  # Arguments parser
import ujson as json  # Fast JSON parser
from termcolor import cprint  # Colors in the console output

from modules import kafkaIO  # IO operations with kafka topics


def process_results(data_to_process, producer, output_topic):
    """
    Process analyzed data and modify it into desired output.
    :param data_to_process: analyzed data
    :param producer: Kafka producer
    :param output_topic: Kafka topic through which output is send
    """

    # Here you can format your results output and send it to the kafka topic
    # <-- INSERT YOUR CODE HERE

    # Example of a transformation function that selects values of the dictionary and dumps them as a string
    results_output = '\n'.join(map(json.dumps, data_to_process.values()))

    # Send desired output to the output_topic
    kafkaIO.send_data_to_kafka(results_output, producer, output_topic)


def process_input(input_data):
    """
    Process raw data and do MapReduce operations.
    :param input_data: input data in JSON format to process
    :return: processed data
    """
    # Here you can process input stream with MapReduce operations
    # <-- INSERT YOUR CODE HERE

    # Example of the map function that transform all JSONs into the key-value pair with the JSON as value and static key
    modified_input = input_data.map(lambda json_data: (1, json_data))

    return modified_input


if __name__ == "__main__":
    # Define application arguments (automatically creates -h argument)
    parser = argparse.ArgumentParser()
    parser.add_argument("-iz", "--input_zookeeper", help="input zookeeper hostname:port", type=str, required=True)
    parser.add_argument("-it", "--input_topic", help="input kafka topic", type=str, required=True)
    parser.add_argument("-oz", "--output_zookeeper", help="output zookeeper hostname:port", type=str, required=True)
    parser.add_argument("-ot", "--output_topic", help="output kafka topic", type=str, required=True)
    parser.add_argument("-m", "--microbatch", help="microbatch duration", type=int, required=False, default=5)

    # You can add your own arguments here
    # See more at:
    # https://docs.python.org/2.7/library/argparse.html

    # Parse arguments
    args = parser.parse_args()

    # Initialize input stream and parse it into JSON
    ssc, parsed_input_stream = kafkaIO\
        .initialize_and_parse_input_stream(args.input_zookeeper, args.input_topic, args.microbatch)

    # Process input in the desired way
    processed_input = process_input(parsed_input_stream)

    # Initialize kafka producer
    kafka_producer = kafkaIO.initialize_kafka_producer(args.output_zookeeper)

    # Process computed data and send them to the output
    kafkaIO.process_data_and_send_result(processed_input, kafka_producer, args.output_topic, process_results)

    # Start Spark streaming context
    kafkaIO.spark_start(ssc)