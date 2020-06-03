FROM debian:9

RUN apt update && apt install -y \
python3-pip \
odbc-postgresql \
unixodbc-dev \
gunicorn3 \
git \
bash \
netcat \
wget

RUN apt install -y \
subversion g++ zlib1g-dev build-essential git python rsync man-db \
libncurses5-dev gawk gettext unzip file libssl-dev wget zip tar redis-server

COPY . /asu
COPY odbc.ini ~/.odbc.ini
WORKDIR /asu

RUN pip3 install -e .
RUN pip3 install -r requirements.txt
RUN pip3 install asu
RUN export FLASK_APP=asu  # set Flask app to asu
RUN flask janitor update  # download upstream profiles/packages


EXPOSE 8000
RUN chmod +x /usr/src/asu/docker-entrypoint.sh
ENTRYPOINT ["/usr/src/asu/docker-entrypoint.sh"]

CMD
