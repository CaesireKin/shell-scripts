# !/bin/bash

container_name=$1
docker_volumes=$2;
redis_password=$3;

if [ ! $container_name ] || [ ! $docker_volumes ] || [ ! $redis_password ]; then
  echo "Usage: ./docker-dev-env-init \${container_name} \${docker_volumes} \${redis_password}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
docker run --name $container_name -p 6379:6379 -v $docker_volumes/$container_name/data:/data -d redis redis-server --appendonly yes;
