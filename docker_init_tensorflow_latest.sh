# !/bin/bash

container_name=$1;
volume_dir=$2;
service_port=$3;
jupyter_port=$4;
# user=$5;

if [ ! $container_name ] || [ ! $volume_dir ] || [ ! $service_port ] || [ ! $jupyter_port ]; then # || [ ! $user ]; then
    echo 'Usage ./docker_init_gitlab.sh \${container_name} \${volume_dir} \${service_port} \${server_dir} \${jupyter_port} \${user_mapping_as_container_root';
    exit -1;
fi

echo 'Drop if there is already exist an instance ...'
sudo docker container stop $container_name;
sudo docker container rm $container_name;
echo "Docker Volumes: $volume_dir, starting initializing...";
sudo docker run -it --name $container_name \
    -p $jupyter_port:8888 -p $service_port:5000 \
    -v $volume_dir/$container_name/server:/var/tensorflow_server -v $volume_dir/$container_name/jupyter:/tf/notebooks \
    -d tensorflow/tensorflow:latest-py3-jupyter
echo "Starting Tensorflow Server Configure"
sudo docker exec -it tensorflow bash
# apt update && apt upgrade
# apt install vim
# pip install --upgrade pip
# pip install flask
# cd /var/tensorflow_server && mkdir apis models
