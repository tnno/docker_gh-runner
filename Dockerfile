FROM debian:bullseye-slim

LABEL version="0.1" maintainer="Tino Naumann <maintain@tnno.de>"

ENV DEBIAN_FRONTEND "noninteractive"
ENV TOKEN ""
ENV GH_URL ""
ENV RUNNER_VERSION "2.285.1"
ENV RUNNER_TYPE "linux-x64"
ENV RUNNER_NAME "test-runner"
ENV RUNNER_LABELS "test-label"

COPY start.sh /start.sh

WORKDIR /app/actions-runner

RUN apt update && \
    apt -y install curl docker.io && \
    rm -rf /var/lib/apt/lists/* && \
    useradd ghrunner && \
    curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-$RUNNER_TYPE-$RUNNER_VERSION.tar.gz && \
    tar xzf ./actions-runner.tar.gz && \
    rm actions-runner.tar.gz && \
    ./bin/installdependencies.sh && \
    chmod o+w .

USER ghrunner

ENTRYPOINT ["/bin/bash", "/start.sh"]
