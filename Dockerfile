FROM ashlineldridge/java-on-ubuntu
MAINTAINER Ashlin Eldridge

# Install things needed by Go
RUN apt-get update
RUN apt-get install -y unzip git subversion

# Install the Go server
RUN wget http://download01.thoughtworks.com/go/13.4.1/ga/go-server-13.4.1-18342.deb -O /tmp/go-server.deb
# ADD go-server-13.4.1-18342.deb /tmp/go-server.deb
RUN dpkg -i /tmp/go-server.deb

# Expose ports for HTTP and HTTPS
EXPOSE 8153
EXPOSE 8154

# Go db so it is not part of the container
VOLUME /var/lib/go-server/db
# Go configuration
VOLUME /etc/go

# This is where we will place go related files - password files, etc.
VOLUME /go-server

ADD start.sh /usr/local/bin/start
ADD id_rsa /var/go/.ssh/id_rsa
ADD id_rsa.pub /var/go/.ssh/id_rsa.pub
ADD known_hosts /var/go/.ssh/known_hosts

RUN chmod -R 600 /var/go/.ssh/*
RUN chown -R go:go /var/go

CMD chown -R go:go /var/lib/go-server/db && chown -R go:go /etc/go && start
