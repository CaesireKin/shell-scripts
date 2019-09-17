
# !/bin/bash

container_name=$1;
volume_dir=$2;

if [ ! $container_name ] || [ ! $volume_dir ]; then
    echo 'Usage ./docker_init_gitlab_runner_latest.sh \${container_name} \${volume_dir}';
    exit -1;
fi

echo 'Drop if there is already exist an instance ...'
sudo docker container stop $container_name;
sudo docker container rm $container_name;
echo "Docker Volumes: $volume_dir, starting initializing...";