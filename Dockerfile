FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends 
build-essential 
ca-certificates 
cmake 
gperf 
git 
libssl-dev 
zlib1g-dev 
&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN git submodule update --init --recursive

RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release 
&& cmake --build build --target telegram-bot-api -j2

EXPOSE 8081

CMD ["sh", "-c", "exec ./build/telegram-bot-api --api-id=${TELEGRAM_API_ID:?Missing TELEGRAM_API_ID} --api-hash=${TELEGRAM_API_HASH:?Missing TELEGRAM_API_HASH} --http-port=8081"]
