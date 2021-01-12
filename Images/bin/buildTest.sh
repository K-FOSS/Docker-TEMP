#!/bin/sh
BASEDIR=$(dirname "$0")

PUSH_IMAGES="kristianfoss/programs-caddy kristianfoss/source-minio kristianfoss/programs-minio"

cd "${BASEDIR}/../Extras/Builder/"
./setup.sh
docker-compose up -d
docker-compose ps
docker ps
docker ps -a

sleep 30

docker-compose exec -T -w /workspace Docker docker login -u ${USERNAME} -p ${PASSWORD}

docker-compose exec -T -w /workspace Docker docker info
docker-compose exec -T -w /workspace Docker docker run --rm hello-world
docker-compose exec -T -w /workspace Docker docker ps -a

docker-compose exec -T -w /workspace Docker docker buildx bake -f ./docker-compose.build.source.yml
docker-compose exec -T -w /workspace Docker docker buildx bake -f ./docker-compose.build.yml

for IMAGE in ${PUSH_IMAGES}; do
  docker-compose exec -T -w /workspace Docker docker push ${IMAGE}
done