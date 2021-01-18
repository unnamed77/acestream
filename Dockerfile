FROM ubuntu:18.04 as builder

ARG VERSION="3.1.49_ubuntu_18.04"
RUN apt-get update &&\
        apt-get install --no-install-recommends --yes wget && \
        apt-get clean && \
        rm --force --recursive /var/lib/apt/lists
RUN     mkdir /opt/acestream && \
        wget -O- --no-check-certificate "https://github.com/unnamed77/acestream/raw/master/acestream_3.1.49_ubuntu_18.04_x86_64.tar.gz" | \
        tar -xz -C /opt/acestream

# actual image
FROM ubuntu:18.04
LABEL maintainer="Fedor <unnamed.06@mail.ru>"
RUN apt-get update --yes && \
        apt-get install --no-install-recommends --yes \
        apt-utils python-setuptools python-m2crypto python-apsw libpython2.7 libssl1.0.0 net-tools libxslt1.1 && \
        apt-get clean && \
        rm --force --recursive /var/lib/apt/lists
COPY --from=builder /opt/acestream /opt/acestream

EXPOSE 6878

ENV ACESTREAM_ROOT="/opt/acestream"
ENV LD_LIBRARY_PATH="${ACESTREAM_ROOT}/lib"

CMD ["/opt/acestream/acestreamengine", "--bind-all", "--client-console", "--live-cache-type memory", "--live-mem-cache-size 209715200"]
