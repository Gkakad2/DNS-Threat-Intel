FROM ubuntu:24.04

WORKDIR /app

RUN apt update && apt install -y \
    bash grep sed gawk coreutils \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN chmod +x dns_parser.sh update_feeds.sh

CMD ["./dns_parser.sh"]
