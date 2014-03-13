FROM ashlineldridge/java-on-ubuntu
MAINTAINER Ashlin Eldridge

# Install things needed by Go
RUN apt-get install -y unzip git subversion

# Install the Go server
# RUN wget http://download01.thoughtworks.com/go/13.4.1/ga/go-server-13.4.1-18342.deb -O /tmp/go-server.deb
ADD go-server-13.4.1-18342.deb /tmp/go-server.deb
RUN dpkg -i /tmp/go-server.deb

# Expose ports for HTTP and HTTPS
EXPOSE 8153
EXPOSE 8154

VOLUME /var/lib/go-server/db/h2db

ADD start.sh /usr/local/bin/start

CMD chown -R go:go /var/lib/go-server/db/h2db && start
