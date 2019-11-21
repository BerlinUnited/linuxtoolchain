# Base OS layer: Latest Ubuntu LTS.
FROM ubuntu:18.04

# Install system dependencies
RUN apt-get update -y --fix-missing
RUN apt-get upgrade -y
RUN apt-get install openjdk-8-jre build-essential cmake zlib1g-dev git libreadline-dev gettext -y

# Set the working directory to /naoth
WORKDIR /naoth/toolchain

# Copy the current directory contents into the container at /naoth
COPY . /naoth/toolchain

# setup the toolchain libs
RUN yes Y | ./setup.sh