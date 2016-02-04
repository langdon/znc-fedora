# version 1.4-1
# docker-version 0.11.1
FROM        fedora:23
MAINTAINER  langdon "langdon@fedoraproject.org"

RUN         dnf -y update
#need znc-devel for building modules
RUN         dnf -y install sudo znc znc-devel @development-tools openssl-devel perl-devel
#for building znc-push
RUN         dnf -y install gcc-c++ redhat-rpm-config
RUN         dnf -y install libcurl-devel libicu-devel

RUN         usermod -u 2000 znc
RUN         groupmod -g 2000 znc
ADD         start-znc /usr/local/bin/
RUN         chmod a+x /usr/local/bin/start-znc
ADD         znc.conf.default /src/
RUN         chmod 644 /src/znc.conf.default
ADD	    ./modules /src/modules
ADD	    ./configs/*.conf /src/configs/

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
# you may need to run
# docker run -it  -v /tmp/znc-data:/znc-data --entrypoint "/bin/bash" test/znc
# then /usr/local/bin/start-vnc to generate a pem file if you already have configs
# then exit and...
#
# run with
# docker run -d -p 6667:6667 -p 6697:6697 -v /mnt/znc-data:/znc-data ${USER}/znc
