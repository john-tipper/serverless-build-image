FROM nikolaik/python-nodejs:python3.10-nodejs16-slim

LABEL "com.github.actions.name"="serverless-build-image"
LABEL "com.github.actions.description"="Serverless Framework build image with additional tooling."
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="red"

RUN npm i -g serverless@3.x @serverless/compose

RUN apt-get update \
    && apt-get install -y make curl \
    && apt-get clean \
    && pip install pipx \
    && pipx install awscli

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH=$PATH:/root/.local/bin:/root/.cargo/bin
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | bash

ENTRYPOINT ["serverless"]
