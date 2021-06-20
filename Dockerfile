#Heroku Support
FROM python:3.9
RUN apt update && apt upgrade -y && apt install php nginx libncurses-dev nodejs npm tmux byobu screen neofetch git -y
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
RUN mkdir /krypton
COPY . /krypton
WORKDIR /krypton
ENV TERM=xterm
RUN git clone https://github.com/krypton-byte/BLACKICEcoder
RUN apt-get install build-essential cmake git libjson-c-dev libwebsockets-dev -y && git clone https://github.com/tsl0922/ttyd.git && cd ttyd && mkdir build && cd build && cmake .. && make && make install
RUN echo "print(\" Hallo World \")" > /home/test.py
RUN chmod -R 777 /run/screen
CMD python3 gen.nginx.py>/etc/nginx/sites-enabled/default &&  rm /krypton/Dockerfile /krypton/gen.nginx.py /krypton/heroku.yml   &&nginx&&php -S 0.0.0.0:8000 -t /krypton/BLACKICEcoder&cd /home&&ttyd -p 8001 bash
