
set DOWNLOAD_NGINX_URL="http://nginx.org/download/nginx-1.23.2.zip"
set DOCKER_IMAGE=nginx:latest

docker build --build-arg DOWNLOAD_NGINX_URL="%DOWNLOAD_NGINX_URL%" -t %DOCKER_IMAGE% .

