docker rmi -f $(docker images -a -q)
docker build -t flask .
docker tag flask ashfaqbarkati786/flask1
docker push ashfaqbarkati786/flask1