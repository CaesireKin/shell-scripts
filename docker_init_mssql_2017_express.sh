# !/bin/bash

container_name=$1
docker_volumes=$2;
mssql_sa_password=$3;
#mongo_admin_password=$5;
#mongo_express_admin_password=$6;
#redis_password=$7;

if [ ! $container_name ] || [ ! $docker_volumes ] || [ ! $mssql_sa_password ]; then
  echo "Usage: ./docker-dev-env-init \${container_name} \${docker_volumes} \${mssql_sa_password}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
# docker run --name $container_name -p 1433:1433 -v $docker_volumes/mssql/express/data:/var/opt/mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=$mssql_sa_password' -e 'MSSQL_PID=Express' -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu;
docker run --name $container_name -p 1433:1433 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD='$mssql_sa_password -e 'MSSQL_PID=Express' -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu;

# if [ ! -n $mongo_admin_password ]; then
if [ $mongo_admin_password ]; then
  echo "Initialize MongoDB 4 ...";
  # Create the mongodb instance handle data storage
  docker container stop mongo4;
  docker container rm mongo4;
  docker run --name mongo4 -p 27017:27017 -v $docker_volumes/mongo/4/data:/data/db -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=$mongo_admin_password -d mongo --wiredTigerCacheSizeGB 0.5;
fi

# if [ ! -n $mongo_express_admin_password ]; then
if [ $mongo_express_admin_password ]; then
  echo "Initialize Mongo Express ...";
  # Setup a Web base mongodb management tool
  docker container stop mongo-express;
  docker container rm mongo-express;
  docker run --name mongo-express --link mongo4:mongo -p 27018:8081 -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" -e ME_CONFIG_MONGODB_SERVER="mongo" -e ME_CONFIG_BASICAUTH_USERNAME="admin" -e ME_CONFIG_BASICAUTH_PASSWORD="$mongo_express_admin_password" -d mongo-express;
fi

# if [ ! -n $redis_password ]; then
if [ $redis_password ]; then
  echo "Initialize Redis 5 ...";
  # Create the redis instance handle caches .etc
  docker container stop redis5;
  docker container rm redis5;
  docker run --name redis5 -p 6379:6379 -v $docker_volumes/redis/5/data:/data -d redis redis-server --appendonly yes;
fi
