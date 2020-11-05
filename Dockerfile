#Build:
#   	sudo docker build -t "sight:9.0-devel-ubuntu16.04" .
#Run:
#	sudo nvidia-docker run -it -p 9002:9002 sight:9.0-devel-ubuntu16.04 bash
 
FROM centos:centos7

LABEL maintainer "Benjha"

RUN yum -y update 
RUN yum install -y epel-release 
RUN yum install -y  \
        ca-certificates git wget systemd httpd pciutils \
        vim curl git nasm \
        boost-devel \
        cmake3 cmake-gui net-tools
RUN yum group install -y "Development Tools"
RUN yum clean all

RUN alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake 10 \
    --slave /usr/local/bin/ctest ctest /usr/bin/ctest \
    --slave /usr/local/bin/cpack cpack /usr/bin/cpack \
    --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake \
    --family cmake

RUN alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake3 20 \
    --slave /usr/local/bin/ctest ctest /usr/bin/ctest3 \
    --slave /usr/local/bin/cpack cpack /usr/bin/cpack3 \
    --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake3 \
    --family cmake

# jansson
RUN git clone -b 2.11 https://github.com/akheron/jansson.git &&\
    cd jansson &&\
    mkdir .build &&\
    cd .build &&\
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local  -DJANSSON_BUILD_DOCS=OFF .. &&\
    make -j4 install

# libwebsockets
RUN git clone -b v4.0-stable https://github.com/benjha/libwebsockets.git &&\
    cd libwebsockets &&\
    mkdir .build &&\
    cd .build &&\
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DLWS_WITH_SSL=OFF .. &&\
    make -j4 install &&\
    cd .. &&\
    cd minimal-examples/http-server/minimal-http-server &&\
    cmake . &&\
    make

# libjpeg-turbo
RUN git clone -b master https://github.com/libjpeg-turbo/libjpeg-turbo.git &&\
    cd libjpeg-turbo &&\
    mkdir .build &&\
    cd .build &&\
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. &&\
    make -j4 install


# ISAAC server
RUN git clone -b dev https://github.com/ComputationalRadiationPhysics/isaac.git &&\
    cd isaac &&\
    mkdir .build &&\
    cd .build &&\
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../server &&\
    make -j4 install

# configuring webserver
RUN mkdir /var/www/isaac
RUN cp -r /isaac/client/* /var/www/isaac
RUN cd /isaac
RUN wget https://raw.githubusercontent.com/benjha/docker_isaac/main/httpd.conf
ADD httpd.conf /etc/httpd/conf/httpd.conf
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf


ENV LD_LIBRARY_PATH /usr/local/lib:/usr/local/lib64:/lib:/lib64

# websockets port
EXPOSE 2459
# simulation port
EXPOSE 2460
# webserver port
EXPOSE 8080

WORKDIR /

#RUN bash -c "httpd -DFOREGROUND  &" && sleep 2
CMD ["httpd","-DFOREGROUND"]
#CMD ["isaac","--help"]
