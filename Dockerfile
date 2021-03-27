FROM golang:buster
RUN apt-get update \
  && apt-get install gnupg1 apt-transport-https dirmngr -y \
  && export INSTALL_KEY=379CE192D401AB61 \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY \
  && echo "deb https://ookla.bintray.com/debian generic main" | tee  /etc/apt/sources.list.d/speedtest.list \
  && apt-get update \
  && apt-get install speedtest -y
RUN go get -u github.com/msoap/shell2http \
  && chmod +x bin/shell2http
RUN apt-get install jq -y
COPY ./speedtest.sh ./
RUN chmod +x speedtest.sh
CMD ./bin/shell2http -port=9696 /metrics "./speedtest.sh"

