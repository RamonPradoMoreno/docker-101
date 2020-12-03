# You always start from an image from the docker repository (docker hub)
# Here I am using a python slim image provided by the docker hub.
FROM python:3.9-slim
# Here we establish the dir where we will be working from
WORKDIR /scripts
# Here we copy a local script into the image.
COPY my_script.py .
# The command to execute when the container is started
# The u flag is for being able to see the prints in the logs
CMD ["python3","-u", "my_script.py"]