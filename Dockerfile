FROM python:alpine

COPY trojan trojan
RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
    && (cd trojan && cmake . && make -j $(nproc) && strip -s trojan \
    && mv trojan /usr/local/bin) \
    && rm -rf trojan \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN rm -rf trojan
#COPY ./proxy/trojan /usr/local/bin
#COPY --from=proxy /usr/local/bin/trojan /usr/local/bin

CMD [ "sh", "upodder/config/init.sh"]