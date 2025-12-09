FROM ubuntu:20.04@sha256:8e5c4f0285ecbb4ead070431d29b576a530d3166df73ec44affc1cd27555141b AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl git libssl-dev libudev-dev pkg-config zlib1g-dev llvm clang cmake make libprotobuf-dev protobuf-compiler libclang-dev && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/*.

WORKDIR /build

ARG SOLANA_SHA

RUN git init && \
    git remote add origin "https://github.com/anza-xyz/agave.git" && \
    git fetch --depth=1 origin ${SOLANA_SHA} && \
    git reset --hard FETCH_HEAD


RUN bash -c ". ci/rust-version.sh && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain \$rust_stable && \
    . $HOME/.cargo/env && \
    rustup component add rustfmt"

ENV PATH=/root/.cargo/bin:$PATH

RUN ./cargo build --profile release --bin solana-test-validator

RUN mkdir bin && \
    mv target/release/solana-test-validator /bin/solana-test-validator

FROM ubuntu:20.04@sha256:8e5c4f0285ecbb4ead070431d29b576a530d3166df73ec44affc1cd27555141b AS export

COPY --from=build /bin/solana-test-validator /bin/
