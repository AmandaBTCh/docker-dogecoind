FROM debian:stable-slim

ENV HOME /dogecoin

ENV USER_ID 1000
ENV GROUP_ID 1000

RUN groupadd -g ${GROUP_ID} dogecoin \
  && useradd -u ${USER_ID} -g dogecoin -s /bin/bash -m -d /dogecoin dogecoin \
  && set -x \
  && apt-get update -y \
  && apt-get install -y curl gosu \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DOGECOIN_VERSION=1.10.0

RUN curl -sL https://github.com/dogecoin/dogecoin/releases/download/v${DOGECOIN_VERSION}/dogecoin-${DOGECOIN_VERSION}-linux64.tar.gz | tar xz --strip=2 -C /usr/local/bin

ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/doge_oneshot

VOLUME ["/dogecoin"]

EXPOSE 22555 22556

WORKDIR /dogecoin

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["doge_oneshot"]