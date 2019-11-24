FROM golang:alpine as builder

ADD . /usr/src/ipoib-cni

ENV HTTP_PROXY $http_proxy
ENV HTTPS_PROXY $https_proxy

RUN apk add --update --virtual build-dependencies build-base linux-headers && \
    cd /usr/src/ipoib-cni && \
    make clean && \
    make build

FROM alpine
COPY --from=builder /usr/src/ipoib-cni/build/ipoib /usr/bin/
WORKDIR /

LABEL io.k8s.display-name="IPoIB CNI"

ADD ./images/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]