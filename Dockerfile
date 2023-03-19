# Build container
FROM debian:11-slim AS builder

# Build arguments
ARG BRANCH=master

# install tools and dependencies
RUN apt update && \
  apt upgrade -y && \
  apt install -y python3 python3-pip gcc python3-dev cargo git g++ cmake make curl && \
  git clone -b $BRANCH https://github.com/opentensor/bittensor.git && \
  cd bittensor && \
  pip3 install . --extra-index-url https://download.pytorch.org/whl/cpu && \
  apt purge -y gcc python3-dev cargo git g++ cmake make curl && \
  apt -y autoremove && \
  rm -rf /var/lib/apt/lists/*

# Start inside the bittensor git folder
WORKDIR /bittensor

