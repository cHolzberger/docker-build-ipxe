FROM mosaiksoftware/debian
#
# PHP Farm Docker image
#

MAINTAINER Christian Holzberger, ch@mosaiksoftware.de

ENV IPXE_WITH_HTTPS="no"
ENV IPXE_PRODUCTNAME="debian-ipxe-build-script"
ENV IPXE_CONFIG="/ipxe/dhcp.ipxe"

#COPY config /etc
COPY selections /selections
# add hhvm key
ENV DEBIAN_FRONTEND noninteractive
# make php 5.3 work again
#ENV LDFLAGS "-lssl -lcrypto"
#RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
# add some build tools
RUN begin-apt && \
			apt-get install -y ca-certificates && \
    	set-selections ipxe-basic && \
		end-apt

COPY bin/fetch-ipxe /bin/fetch-ipxe
RUN /bin/fetch-ipxe
COPY bin/build-ipxe /bin/build-ipxe
#VOLUME /usr/src/ipxe/bin
ENTRYPOINT ["/bin/bash"]
CMD ["/bin/build-ipxe"]
