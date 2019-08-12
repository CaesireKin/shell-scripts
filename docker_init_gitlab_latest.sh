# !/bin/bash

container_name=$1;
hostname=$2
volume_dir=$3;

if [ ! $container_name ] || [ ! $volume_dir ]; then
    echo 'Usage ./docker_init_gitlab.sh \${container_name} \${hostname} \${docker_volume_dir}';
    exit -1;
fi

echo 'Drop if there is already exist an instance ...'
sudo docker container stop $container_name;
sudo docker container rm $container_name;
echo "Docker Volumes: $docker_volumes, starting initializing...";
sudo docker run --name $container_name --hostname $hostname -p 443:443 -p 80:80 --restart always -v $volume_dir/$container_name/config:/etc/gitlab -v $volume_dir/$container_name/logs:/var/log/gitlab -v $volume_dir/$container_name/data:/var/opt/gitlab -d gitlab/gitlab-ce;