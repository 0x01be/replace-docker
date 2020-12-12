FROM 0x01be/swig:4.0 as swig

FROM 0x01be/base

COPY --from=swig /opt/swig/ /opt/swig/

ENV PATH=${PATH}:/opt/swig/bin \
    SWIG_DIT=/opt/swig \
    SWIG_EXECUTABLE=/opt/swig/bin/swig \
    REPLACE_HOME=/replace \
    REVISION=standalone
RUN apk add --no-cache --virtual replace-build-dependencies \
    git \
    build-base \
    cmake \
    zlib-dev \
    tcl-dev \
    tk-dev \
    boost-dev \
    gmp-dev \
    mpfr-dev \
    mpc1-dev \
    libjpeg-turbo-dev \
    imagemagick-dev \
    pcre-dev \
    bison \
    flex \
    rhash &&\
    git clone --recursive --branch ${REVISION} https://github.com/The-OpenROAD-Project/RePlAce.git /replace

WORKDIR /replace/build

RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/replace \
    -DSWIG_EXECUTABLE=/opt/swig/bin/swig \
    .. &&\
    make
RUN make install

