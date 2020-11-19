FROM python:3.8-slim-buster

ENV SAM_CLI_TELEMETRY 0

RUN apt-get update && \
    apt-get install -y && \
    apt-get install -y -qq \
        jq \
        curl \
        bash \
        gcc \
        libffi-dev

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install aws-sam-cli

COPY entrypoint.sh /entrypoint.sh
COPY post_comment.sh /post_comment.sh
ENTRYPOINT ["/entrypoint.sh"]
