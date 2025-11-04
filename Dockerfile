FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    make \
    zip \
    unzip \
    git \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxtst-dev \
    libxt-dev \
    libcups2-dev \
    libfontconfig1-dev \
    libasound2-dev \
    ca-certificates \
    wget \
    openjdk-21-jdk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/openjdk/jdk.git && \
    cd jdk && git checkout jdk-25

WORKDIR /opt/jdk

RUN bash configure \
    --with-boot-jdk=/usr/lib/jvm/java-21-openjdk-amd64 \
    --disable-warnings-as-errors \
    --enable-debug

RUN make images

ENV PATH="/opt/jdk/build/linux-x86_64-server-release/images/jdk/bin:${PATH}"

CMD ["java", "-version"]