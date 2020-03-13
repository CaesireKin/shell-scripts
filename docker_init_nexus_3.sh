container_name=$1
volume_path=$2
admin_port=$3
docker_registry=$4
maven_registry=$5
docker run --name $container_name \
    -p $admin_port:8080 -p $docker_registry -p $maven_registry \
    -v $volume_path/$container_name/data:/nexus-data \
    --restart always -d sonatype/nexus3