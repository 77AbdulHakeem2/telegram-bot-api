FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    g++ \
    make \
    cmake \
    zlib1g-dev \
    libssl-dev \
    gperf \
    php-cli \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git .

RUN mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release .. \
    && cmake --build . --target telegram-bot-api -j2

EXPOSE 8081

CMD ["/app/build/telegram-bot-api", "--http-port=8081", "--http-stat-port=8082"]
