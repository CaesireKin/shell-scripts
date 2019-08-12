# !/bin/bash

container_name=$1
docker_volumes=$2;
mongo_admin_password=$3;
mongo_express_admin_password=$4;

if [ ! $container_name ] || [ ! $docker_volumes ] || [ ! $mongo_admin_password ]; then
  echo "Usage: ./docker_init_mongo_latest.sh \${container_name} \${docker_volumes} \${mongo_admin_password}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
docker run --name $container_name -p 27017:27017 -v $docker_volumes/$container_name/data:/data/db -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=$mongo_admin_password -d mongo --wiredTigerCacheSizeGB 0.5;

if [ $mongo_express_admin_password ]; then
  echo "Initialize Mongo Express ...";
  # Setup a Web base mongodb management tool
  docker container stop mongo-express;
  docker container rm mongo-express;
  docker run --name mongo-express --link $container_name:mongo -p 27018:8081 -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" -e ME_CONFIG_MONGODB_SERVER="mongo" -e ME_CONFIG_BASICAUTH_USERNAME="admin" -e ME_CONFIG_BASICAUTH_PASSWORD="$mongo_express_admin_password" -d mongo-express;
fi