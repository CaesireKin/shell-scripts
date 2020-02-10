container_name=$1
volume_path=$2
expose=$3
docker run --name $container_name -p $expose:8080 -v $volume_path/$container_name/logs:/usr/local/tomcat/logs -v $volume_path/$container_name/temp:/usr/local/tomcat/temp -v $volume_path/$container_name/webapps:/usr/local/tomcat/webapps --restart always -d tomcat:9