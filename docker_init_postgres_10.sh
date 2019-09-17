# !/bin/bash

container_name=$1
docker_volumes=$2;
postgres_root_password=$3;

if [ ! $container_name ] || [ ! $docker_volumes ] || [ ! $postgres_root_password ]; then
  echo "Usage: ./docker_init_postgres_10.sh \${container_name} \${docker_volumes} \${postgres_root_password}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
docker run --name $container_name -p 5432:5432 -v $docker_volumes/$container_name/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=$postgres_root_passwrd --restart always -d postgres:10;