# !/bin/bash

container_name=$1
docker_volumes=$2;
tag=$3

if [ ! $container_name ] || [ ! $docker_volumes ]; then
  echo "Usage: ./docker_init_activemq_latest.sh \${container_name} \${docker_volumes} \${tag}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
echo "docker run --name $container_name -p 8161:8161 -p 61616:61616 -p 5672:5672 -p 61613:61613 -p 1883:1883 -p 61614:61614 -v $docker_volumes/$container_name/$tag/conf:/opt/activemq/conf -v $docker_volumes/$container_name/$tag/data:/opt/activemq/data -d rmohr/activemq:$tag"
docker run --name $container_name -p 8161:8161 -p 61616:61616 -p 5672:5672 -p 61613:61613 -p 1883:1883 -p 61614:61614 -v $docker_volumes/$container_name/$tag/conf:/opt/activemq/conf -v $docker_volumes/$container_name/$tag/data:/opt/activemq/data -d rmohr/activemq:$tag