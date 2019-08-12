# !/bin/bash

container_name=$1
docker_volumes=$2;
mssql_sa_password=$3;

if [ ! $container_name ] || [ ! $docker_volumes ] || [ ! $mssql_sa_password ]; then
  echo "Usage: ./docker_init_mssql_2017_express.sh \${container_name} \${docker_volumes} \${mssql_sa_password}";
  exit -1;
fi

echo "Docker Volumes: $docker_volumes, starting initializing...";
docker container stop $container_name;
docker container rm $container_name;
# docker run --name $container_name -p 1433:1433 -v $docker_volumes/mssql/express/data:/var/opt/mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=$mssql_sa_password' -e 'MSSQL_PID=Express' -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu;
docker run --name $container_name -p 1433:1433 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD='$mssql_sa_password -e 'MSSQL_PID=Express' -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu;