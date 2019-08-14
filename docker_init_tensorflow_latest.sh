# !/bin/bash

container_name=$1;
volume_dir=$2;
jupyter_port=$3;
service_port=$4;

if [ ! $container_name ] || [ ! $volume_dir ] || [ ! $jupyter_port ] || [ ! $service_port ]; then
    echo 'Usage ./docker_init_gitlab.sh \${container_name} \${volume_dir} \${jupyter_port}  \${service_port}';
    exit -1;
fi

echo 'Drop if there is already exist an instance ...'
sudo docker container stop $container_name;
sudo docker container rm $container_name;
echo "Docker Volumes: $volume_dir, starting initializing...";
sudo docker run -it --name $container_name \
    -p $jupyter_port:8888 -p $service_port:5000 \
    -v $volume_dir/$container_name/models:/var/tensorflow/models -v $volume_dir/$container_name/jupyter:/ef/notebooks \
    -d tensorflow/tensorflow:latest-py3-jupyter