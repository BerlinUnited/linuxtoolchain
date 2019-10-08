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

ENV NAOTH_TOOLCHAIN_PATH=/naoth/toolchain
ENV PATH="${PATH}:${NAOTH_TOOLCHAIN_PATH}/toolchain_native/extern/bin:${NAOTH_TOOLCHAIN_PATH}/toolchain_native/extern/lib"
ENV NAO_CTC="${NAOTH_TOOLCHAIN_PATH}/toolchain_nao/"
ENV EXTERN_PATH_NATIVE="${NAOTH_TOOLCHAIN_PATH}/toolchain_native/extern/"

# setup the toolchain libs
RUN chmod a+x ./docker_setup.sh
RUN ./docker_setup.sh
