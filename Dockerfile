FROM debian:latest
#FROM debian:jessie-slim
ADD . /

RUN file="$(ls *.deb | head -1)" && \ 
   apt-get update && \ 
   apt-get -yq install default-jre-headless systemd sudo curl python python-pip libyajl2 git &&  \ 
   pip install requests python-dateutil pytz ijson yajl protobuf && \
   dpkg -i $file && \ 
   apt-get install -f && \
   /opt/stackstate/bin/sts.sh register --key 89B30-03X84-D33B3 && \ 
   chown -R stackstate:stackstate /opt/stackstate && \
   echo "stackstate:passwd" | chpasswd && adduser stackstate sudo && \
   rm -rf $file && \
   rm -rf /var/lib/apt/lists/*

USER stackstate

EXPOSE 7070 7071

CMD ["/opt/stackstate/bin/sts.sh", "start"]
