FROM 0x01be/replace:build as build

FROM 0x01be/base

COPY --from=build /opt/replace/ /opt/replace/

WORKDIR /workspace

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
    libgomp &&\
    adduser -D -u 1000 replace &&\
    chown replace:replace /workspace

USER replace
ENV PATH=${PATH}:/opt/replace/bin/

