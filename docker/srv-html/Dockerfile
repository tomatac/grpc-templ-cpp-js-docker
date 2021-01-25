FROM ubuntu:20.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    python3  \
    && apt-get clean


WORKDIR /websrv
COPY client-web/echotest.html /websrv/
COPY client-web/dist/main.js /websrv/dist/
EXPOSE 8081
CMD ["python3", "-m", "http.server", "8081"]
