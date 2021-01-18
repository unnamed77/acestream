# acestream-engine 
for amd64 whith remote-access and save chache in memmory


save Docker file and build image

 docker build -t acestream .

start container

  docker run --name=acestream-server -p 6878:6878 -p 8621:8621  -d acestream  --restart=always
