# !/bin/bash

container_name=$1
docker_volumes=$2;

if [ ! $container_name ] || [ ! $docker_volumes ]; then
  echo "Usage: ./docker_init_teamcity_latest.sh \${container_name} \${docker_volumes}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
docker run --name $container_name -p 9111:8111 -v $docker_volumes/$container_name/2019.1.3/data:/data/teamcity_server/datadir -v $docker_volumes/$container_name/2019.1.3/logs:/opt/teamcity/logs --restart always -d jetbrains/teamcity-server