# !/bin/bash

container_name=$1
docker_volumes=$2;

if [ ! $container_name ] || [ ! $docker_volumes ]; then
  echo "Usage: ./docker_init_jenkins_latest.sh \${container_name} \${docker_volumes}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
docker run --name $container_name -p 9080:8080 -p 50000:50000 -v $docker_volumes/$container_name/2.60.3:/var/jenkins_home -d jenkins:2.60.3