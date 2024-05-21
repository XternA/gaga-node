FROM debian:stable-slim

LABEL author="XternA"
LABEL description="Unofficial docker image of GaGaNode."

RUN apt update; apt install -y --no-install-recommends sudo curl tar ca-certificates; rm -rf /var/lib/apt/lists/*
RUN rm -rf /sbin/initctl && ln -s /sbin/initctl.distrib /sbin/initctl

WORKDIR /app

RUN case "$(uname -m)" in \
        x86_64) \
            TYPE=60; \
            ;; \
        arm64|aarch64) \
            TYPE=61; \
            ;; \
        armv8l|armv7l|armv6l) \
            TYPE=72; \
            ;; \
        *) \
            echo "CPU type not supported."; \
            exit 1; \
            ;; \
    esac; \
    LINK="https://assets.coreservice.io/public/package/$TYPE/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz"; \
    FILENAME="app-linux.tar.gz"; \
    curl -L -o $FILENAME $LINK; \
    tar -xzvf $FILENAME; \
    rm -f $FILENAME

COPY . .

RUN chmod 777 ./run.sh
CMD ./run.sh; sleep infinity
