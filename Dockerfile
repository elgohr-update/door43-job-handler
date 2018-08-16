FROM python:alpine

ADD . /code
WORKDIR /code

RUN pip3 install --requirement requirements.txt

# EXPOSE 6379

CMD [ "rq", "worker", "--config", "rq_settings" ]

# Define environment variables
# NOTE: The following environment variables are expected to be set for testing:
#	TX_DATABASE_PW
#	AWS_ACCESS_KEY_ID
#	AWS_SECRET_ACCESS_KEY
# NOTE: The following environment variables are optional:
#	REDIS_URL (can be omitted for testing to use a local instance)
#	DEBUG_MODE (can be set to any non-blank string to run in debug mode for testing)
#	GRAPHITE_HOSTNAME (defaults to localhost if missing)
#	QUEUE_PREFIX (defaults to '', set to dev- for testing)


# NOTE: To build use:
#           docker build --tag door43_job_handler .


#       To test (assuming that the confidential environment variables are already set in the current environment) use:
#           docker run --env TX_DATABASE_PW --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --env QUEUE_PREFIX=dev- --env DEBUG_MODE=True --net="host" --name door43_job_handler --rm door43_job_handler


#       To run in production use with the desired values:
#           docker run --env TX_DATABASE_PW=<tx_db_pw> --env AWS_ACCESS_KEY_ID=<access_key> --env AWS_SECRET_ACCESS_KEY=<sa_key> --env GRAPHITE_HOSTNAME=<graphite_hostname> --env REDIS_URL=<redis_url> --net="host" --name door43_job_handler --rm door43_job_handler
