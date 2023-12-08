FROM ubuntu:20.04

COPY BAIK_* /tmp/
RUN apt-get update && \
    apt-get install -y wget unzip gcc && \
    wget https://sourceforge.net/projects/baik/files/baik-source/baik%20versi%20$(cat /tmp/BAIK_VERSION)%20source/baik9_source_$(cat /tmp/BAIK_VERSION)-2021.zip/download \
        -O /tmp/baik.zip && \
    mkdir -p /opt && \
    cd /opt && \
    unzip /tmp/baik.zip && \
    rm -f /tmp/baik.zip && \
    mv baik* baik && \
    cd baik && \
    gcc -o baik -DLINUX \
        -I/usr/include -I/usr/local/include \
        -L/usr/lib -L/usr/lib64 -L/usr/local/lib  \
        tbaik.c baik_ident.c baik_stack.c baik_expression.c \
        baik_compare.c baik_factor.c interpreter.c interpreterSub.c interpreterClass.c \
        -lpthread -lm -lg && \
    cp -p baik /usr/local/bin && \
    cd / && \
    apt-get remove -y wget unzip gcc && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /opt/baik
