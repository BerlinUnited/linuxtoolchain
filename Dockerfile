# Base OS layer: Latest Ubuntu LTS.
FROM scm.cms.hu-berlin.de:4567/berlinunited/tools/linuxtoolchain:toolchain_base_image

# Set the working directory to /naoth
WORKDIR /naoth/toolchain

# Copy the current directory contents into the container at /naoth
COPY . /naoth/toolchain

ENV NAOTH_TOOLCHAIN_PATH=/naoth/toolchain
ENV PATH="${PATH}:${NAOTH_TOOLCHAIN_PATH}/toolchain_native/extern/bin:${NAOTH_TOOLCHAIN_PATH}/toolchain_native/extern/lib"
ENV NAO_CTC="${NAOTH_TOOLCHAIN_PATH}/toolchain_nao/"
ENV EXTERN_PATH_NATIVE="${NAOTH_TOOLCHAIN_PATH}/toolchain_native/extern/"

# setup the toolchain libs
RUN yes Y | ./setup.sh && rm -rf toolchain_native/extern/extracted && rm -rf toolchain_native/extern/downloads
