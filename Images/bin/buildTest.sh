#!/bin/sh
BASEDIR=$(dirname "$0")

PUSH_IMAGES="kristianfoss/programs-caddy"

cd "${BASEDIR}/../Extras/Builder/"
./setup.sh
docker-compose up -d

sleep 15

docker-compose exec -T -w /workspace Docker docker login -u ${USERNAME} -p ${PASSWORD}

docker-compose exec -T -w /workspace Docker docker buildx bake -f ./docker-compose.build.source.yml
docker-compose exec -T -w /workspace Docker docker buildx bake -f ./docker-compose.build.yml

for IMAGE in ${PUSH_IMAGES}; do
  docker-compose exec -T -w /workspace Docker docker push ${IMAGE}
done