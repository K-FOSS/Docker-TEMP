#!/bin/bash
VOLUME_NAME="docker-socket"
VOLUME2_NAME="dockercli-data"
ALPINE="alpine"
CHOWN_IMAGE="kristianfoss/programs-chown:chown-stable-scratch"
TOUCH_IMAGE="kristianfoss/programs-touch:touch-stable-scratch"
LS_IMAGE="kristianfoss/programs-ls:ls-stable-scratch"

createVolume() {
  volumeName=${1}
  echo "Volume name: ${volumeName}"

  if [ ! "$(docker volume ls -q -f name=${volumeName})" ]; then
    echo "Socket volume does not already exists. Creating now"
    # Create SSH Agent socket volume if it doesn't exist
    docker volume create ${volumeName} &>/dev/null

    if [ ! "${?}" ]; then
      echo "Could not create socket volume" >&2
      return 1
    else
      echo "Successfully created socket volume"

      docker run -it --rm -v ${volumeName}:/tmp/data/socket --user 0 ${TOUCH_IMAGE} /tmp/data/socket/helloWorld
      docker run -it --rm -v ${volumeName}:/tmp/data/socket --user 0 ${CHOWN_IMAGE} -R 1000:1000 /tmp
      return 0
    fi
  else
    echo "Docker volume already exists"
    return 0
  fi
}

createVolume "${VOLUME_NAME}"

echo "Volume2?"
createVolume "${VOLUME2_NAME}"

docker run --privileged --rm -v /:/host alpine chmod o=rw /host/dev/net/tun