# !/bin/bash

container_name=$1
docker_volumes=$2;
mysql_root_password=$3;

if [ ! $container_name ] || [ ! $docker_volumes ] || [ ! $mysql_root_password ]; then
  echo "Usage: ./docker_init_mysql_5.sh \${container_name} \${docker_volumes} \${mysql_root_password}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
docker run --name $container_name -p 3306:3306 -v $docker_volumes/$container_name/datas:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=$mysql_root_password --restart always -d mysql:5 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci;