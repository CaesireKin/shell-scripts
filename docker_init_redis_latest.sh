# !/bin/bash

container_name=$1
docker_volumes=$2;
redis_conf=$3;

if [ ! $container_name ] || [ ! $docker_volumes ] || [ ! $redis_conf ]; then
  echo "Usage: ./docker_init_redis_latest.sh \${container_name} \${docker_volumes} \${redis_conf}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;

if [ ! $redis_conf ]; then
  echo "Initialize redis without redis.conf";
  docker run --name $container_name -p 6379:6379 -v $docker_volumes/$container_name/data:/data --memory=256M --memory-swap=256M --cpus=1 --restart always -d redis redis-server --appendonly yes;
else
  echo "Initialize redis with redis.conf";
  docker run --name $container_name -p 6379:6379 -v $docker_volumes/$container_name/conf/redis.conf:/usr/local/etc/redis/redis.conf -v $docker_volumes/$container_name/data:/data --memory=256M --memory-swap=256M --cpus=1 --restart always -d redis redis-server --appendonly yes;
fi
