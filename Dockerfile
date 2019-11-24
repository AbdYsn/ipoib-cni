FROM golang:alpine as builder

ADD . /usr/src/infiniband-cni

ENV HTTP_PROXY $http_proxy
ENV HTTPS_PROXY $https_proxy

RUN apk add --update --virtual build-dependencies build-base linux-headers && \
    cd /usr/src/infiniband-cni && \
    make clean && \
    make build

FROM alpine
COPY --from=builder /usr/src/infiniband-cni/build/infiniband /usr/bin/
WORKDIR /

LABEL io.k8s.display-name="INFINIBAND CNI"

ADD ./images/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]