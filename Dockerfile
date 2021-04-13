FROM python:alpine

COPY trojan trojan
RUN apk add --no-cache --virtual .build-deps-for-trojan \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
    && (cd trojan && cmake . && make -j $(nproc) && strip -s trojan \
    && mv trojan /usr/local/bin) \
    && rm -rf trojan \
    && apk del .build-deps-for-trojan \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

WORKDIR /app
COPY requirements.txt ./
RUN apk add --no-cache --virtual .build-deps-for-cryptography \
        gcc \
        musl-dev \
        python3-dev \
        libffi-dev \
        openssl-dev \
        cargo \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps-for-cryptography
COPY . .
RUN rm -rf trojan
#COPY ./proxy/trojan /usr/local/bin
#COPY --from=proxy /usr/local/bin/trojan /usr/local/bin
ENV TZ Asia/Shanghai
CMD [ "sh", "upodder/config/init.sh"]