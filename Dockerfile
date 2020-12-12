FROM 0x01be/replace:build as build

FROM alpine:3.12.2

RUN apk add --no-cache --virtual replace-rutime-dependencies \
    zlib \
    tcl \
    tk \
    gmp \
    mpfr \
    mpc1 \
    libjpeg-turbo \
    imagemagick \
    pcre \
    rhash \
    libgomp

COPY --from=build /opt/replace/ /opt/replace/

RUN adduser -D -u 1000 replace

WORKDIR /workspace

RUN chown replace:replace /workspace

USER replace

ENV PATH=${PATH}:/opt/replace/bin/

