FROM debian:stable-slim

ENV HOME /dogecoin

ENV USER_ID 1000
ENV GROUP_ID 1000

RUN groupadd -g ${GROUP_ID} dogecoin \
  && useradd -u ${USER_ID} -g dogecoin -s /bin/bash -m -d /dogecoin dogecoin \
  && set -x \
  && apt-get update -y \
  && apt-get install -y curl gosu

ENV DOGECOIN_VERSION=1.10.0

RUN curl -O https://github.com/dogecoin/dogecoin/releases/download/v1.10.0/dogecoin-${DOGECOIN_VERSION}-linux64.tar.gz \
  && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz

ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/doge_oneshot

VOLUME ["/dogecoin"]

EXPOSE 22555 22556

WORKDIR /dogecoin

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["doge_oneshot"]