FROM 0x01be/replace:build as build

FROM alpine

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
    rhash

COPY --from=build /opt/replace/ /opt/replace/

