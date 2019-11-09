# !/bin/bash

container_name=$1;
volume_dir=$2;

if [ ! $container_name ] || [ ! $volume_dir ]; then
    echo 'Usage ./docker_init_gitlab.sh \${container_name} \${docker_volume_dir}';
    exit -1;
fi

docker container stop $container_name;
docker container rm $container_name;
docker run --name $container_name -p 80:80 -p 443:443 -v $volume_dir/$container_name/html:/usr/share/nginx/html:ro -v $volume_dir/$container_name/conf/:/etc/nginx.conf:ro --restart always -d nginx;