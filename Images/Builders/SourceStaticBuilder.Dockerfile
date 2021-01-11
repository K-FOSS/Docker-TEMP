# syntax=docker/dockerfile:experimental
ARG BUILD_IMAGE='alpine'
ARG ALPINE='alpine'
ARG BINARY_NAME='binary'
ARG FINAL_BASE='scratch'

ARG DEP1='alpine'
ARG DEP1SRC='/tmp'
ARG DEP1DEST='/tmp'

ARG DEP2='alpine'
ARG DEP2SRC='/tmp'
ARG DEP2DEST='/tmp'


ARG DEP3='alpine'
ARG DEP3SRC='/tmp'
ARG DEP3DEST='/tmp'

ARG DEP4='alpine'
ARG DEP4SRC='/tmp'
ARG DEP4DEST='/tmp'

ARG DEP5='alpine'
ARG DEP5SRC='/tmp'
ARG DEP5DEST='/tmp'

ARG DEP6='alpine'
ARG DEP6SRC='/tmp'
ARG DEP6DEST='/tmp'

ARG DEP7='alpine'
ARG DEP7SRC='/tmp'
ARG DEP7DEST='/tmp'

ARG DEP8='alpine'
ARG DEP8SRC='/tmp'
ARG DEP8DEST='/tmp'

ARG DEP9='alpine'
ARG DEP9SRC='/tmp'
ARG DEP9DEST='/tmp'

ARG DEP10='alpine'
ARG DEP10SRC='/tmp'
ARG DEP10DEST='/tmp'

ARG DEP11='alpine'
ARG DEP11SRC='/tmp'
ARG DEP11DEST='/tmp'

ARG DEP12='alpine'
ARG DEP12SRC='/tmp'
ARG DEP12DEST='/tmp'

ARG DEP13='alpine'
ARG DEP13SRC='/tmp'
ARG DEP13DEST='/tmp'


ARG DEP14='alpine'
ARG DEP14SRC='/tmp'
ARG DEP14DEST='/tmp'

ARG DEP15='alpine'
ARG DEP15SRC='/tmp'
ARG DEP15DEST='/tmp'

ARG SOURCE_IMAGE=''
FROM ${SOURCE_IMAGE} as source




FROM ${DEP1} as DEP1


FROM ${DEP2} as DEP2


FROM ${DEP3} as DEP3


FROM ${DEP4} as DEP4


FROM ${DEP5} as DEP5


FROM ${DEP6} as DEP6


FROM ${DEP7} as DEP7


FROM ${DEP8} as DEP8


FROM ${DEP9} as DEP9


FROM ${DEP10} as DEP10


FROM ${DEP11} as DEP11


FROM ${DEP12} as DEP12


FROM ${DEP13} as DEP13


FROM ${DEP14} as DEP14


FROM ${DEP14} as DEP15




FROM ${BUILD_IMAGE} as builder
ARG PKG_ARGS=""

ARG DEFAULT_PKGS='ca-certificates build-base binutils git'
ENV DEFAULT_PKGS ${DEFAULT_PKGS}

ARG PKG_MANAGER='apk add'
ENV PKG_MANAGER ${PKG_MANAGER}

ARG BUILD_PKGS

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt /bin/sh -c "${PKG_MANAGER} ${PKG_ARGS} ${DEFAULT_PKGS} ${BUILD_PKGS}"

ARG DEP1SRC='/tmp'
ARG DEP1DEST='/dev/null'
COPY --from=DEP1 ${DEP1SRC} ${DEP1DEST}


ARG DEP2SRC='/tmp'
ARG DEP2DEST='/dev/null'
COPY --from=DEP2 ${DEP2SRC} ${DEP2DEST}

ARG DEP3SRC='/tmp'
ARG DEP3DEST='/dev/null'
COPY --from=DEP3 ${DEP3SRC} ${DEP3DEST}

ARG DEP4SRC='/tmp'
ARG DEP4DEST='/dev/null'
COPY --from=DEP4 ${DEP4SRC} ${DEP4DEST}

ARG DEP4SRC='/tmp'
ARG DEP4DEST='/dev/null'
COPY --from=DEP4 ${DEP4SRC} ${DEP4DEST}

ARG DEP5SRC='/tmp'
ARG DEP5DEST='/dev/null'
COPY --from=DEP5 ${DEP5SRC} ${DEP5DEST}

ARG DEP6SRC='/tmp'
ARG DEP6DEST='/dev/null'
COPY --from=DEP6 ${DEP6SRC} ${DEP6DEST}

ARG DEP7SRC='/tmp'
ARG DEP7DEST='/dev/null'
COPY --from=DEP7 ${DEP7SRC} ${DEP7DEST}

ARG DEP8SRC='/tmp'
ARG DEP8DEST='/dev/null'
COPY --from=DEP8 ${DEP8SRC} ${DEP8DEST}

ARG DEP9SRC='/tmp'
ARG DEP9DEST='/dev/null'
COPY --from=DEP9 ${DEP9SRC} ${DEP9DEST}

ARG DEP10SRC='/tmp'
ARG DEP10DEST='/dev/null'
COPY --from=DEP10 ${DEP10SRC} ${DEP10DEST}

ARG DEP11SRC='/tmp'
ARG DEP11DEST='/dev/null'
COPY --from=DEP11 ${DEP11SRC} ${DEP11DEST}

ARG DEP12SRC='/tmp'
ARG DEP12DEST='/dev/null'
COPY --from=DEP12 ${DEP12SRC} ${DEP12DEST}

ARG DEP13SRC='/tmp'
ARG DEP13DEST='/dev/null'
COPY --from=DEP13 ${DEP13SRC} ${DEP13DEST}

ARG DEP14SRC='/tmp'
ARG DEP14DEST='/dev/null'
COPY --from=DEP14 ${DEP14SRC} ${DEP14DEST}

ARG DEP15SRC='/tmp'
ARG DEP15DEST='/dev/null'
COPY --from=DEP15 ${DEP15SRC} ${DEP15DEST}

ARG SOURCE_PATH
COPY --from=source /src ${SOURCE_PATH}


ARG BINARY_NAME
RUN mkdir -p /tmp/${BINARY_NAME}/usr/bin


ARG BUILD_PATH=${SOURCE_PATH}
WORKDIR ${BUILD_PATH}

ENV CFLAGS='-O2 -static -static-libgcc'
ENV CXXFLAGS='-O2 -static -static-libgcc'
ENV LDFLAGS='-s'

ARG SETUP_CMD='echo "No build setup command has been set"'
ENV SETUP_CMD=${SETUP_CMD}

RUN /bin/sh -c "${SETUP_CMD}"


ARG BUILD_CMD='echo "no build cmd"'
ENV BUILD_CMD=${BUILD_CMD}

ENV CGO_ENABLED=0 
ENV GOOS=linux
ENV GOARCH=amd64

RUN /bin/sh -c "${BUILD_CMD}"


ARG POST_BUILD_CMD='echo "No post build command has been set"'
ENV POST_BUILD_CMD=${POST_BUILD_CMD}

RUN /bin/sh -c "${POST_BUILD_CMD}"


ARG POST_CMD="echo 'no post cmd'"
ENV POST_CMD=${POST_CMD}

RUN /bin/sh -c "${POST_CMD}"




FROM ${ALPINE} as prepareUser

ARG USER=user
ARG UID=1000
ARG USER_DATA=/data

ENV USER ${USER}
ENV UID ${UID}
ENV USER_DATA ${USER_DATA}

RUN mkdir -p /tmp/out/etc \
  && echo "${USER}:x:${UID}:${UID}::${USER_DATA}:/bin/sh" > /tmp/out/etc/passwd \
  && echo "${USER}:x:${UID}:" > /tmp/out/etc/group




FROM ${ALPINE} as prepareOutput
RUN --mount=type=cache,target=/var/cache/apk apk add binutils ca-certificates


COPY --from=prepareUser /tmp/out /tmp/out

ARG BINARY_NAME
COPY --from=builder /tmp/${BINARY_NAME} /tmp/out


RUN cd /tmp/out/usr/bin \
  && mkdir -p /tmp/out/etc/ssl/certs \
  && mv /etc/ssl/certs/ca-certificates.crt /tmp/out/etc/ssl/certs/ca-certificates.crt \
  && ln -s ./${BINARY_NAME} ./cliLink \
  && chmod +X /tmp/out/usr/bin/${BINARY_NAME} \
  && chmod +X /tmp/out/usr/bin/cliLink \
  && ls -lah /tmp/out/usr/bin

FROM ${FINAL_BASE}
COPY --from=prepareOutput /tmp/out /

ARG USER=user
USER ${USER}:${USER}

ENTRYPOINT ["/usr/bin/cliLink"]