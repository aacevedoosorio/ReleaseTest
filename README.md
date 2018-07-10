docker build -t aacevedo/sts-release .
docker run -d  -p 7070:7070 -p 7071:7071 --name release-1.9.9 aacevedo/sts-release
