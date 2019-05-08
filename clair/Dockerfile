ARG  VERSION=latest

FROM aporeto/clair:${VERSION}

COPY config.yaml /config/config.yaml

CMD ["-config=/config/config.yaml"]
