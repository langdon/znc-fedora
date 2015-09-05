# version 1.4-1
# docker-version 0.11.1
FROM        fedora
MAINTAINER  langdon "langdon@fedoraproject.org"

RUN         yum -y update
#need znc-devel for building modules
RUN         yum -y install sudo znc znc-devel @development-tools openssl-devel perl-devel
#for building znc-push
RUN         yum -y install gcc-c++ redhat-rpm-config
RUN         yum -y install libcurl-devel libicu-devel

RUN         usermod -u 2000 znc
RUN         groupmod -g 2000 znc
ADD         start-znc /usr/local/bin/
RUN         chmod a+x /usr/local/bin/start-znc
ADD         znc.conf.default /src/
RUN         chmod 644 /src/znc.conf.default
ADD	    ./modules /src/modules

VOLUME 	    /znc-data
EXPOSE      6667
EXPOSE      6697
ENTRYPOINT  ["/usr/local/bin/start-znc"]
CMD         [""]

# don't forget to 
# chcon -Rt svirt_sandbox_file_t /path/to/znc-data
#
# build with
# make build
# OR
# docker build -t ${USER}/znc .
#
# run with
# docker run -d -p 6667:6667 -p 6697:6697 -v /mnt/znc-data:/znc-data ${USER}/znc
