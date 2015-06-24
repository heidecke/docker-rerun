# vim:set ft=dockerfile:

FROM centos:6
MAINTAINER Luke Heidecke <luke@solinea.com>

ENV APPDIR /app
WORKDIR $APPDIR

RUN yum -y update && yum -y install \
      epel-release \
      git \
      wget \
      tar \
      bzip2 && \
    yum clean all

RUN yum -y install \
      python \
      python-pip \
      bash-completion && \
    yum clean all

# install rerun
RUN rpm -Uvh http://dl.bintray.com/rerun/rerun-rpm/rerun-1.1.0-1.el6.noarch.rpm

# compile and install discount markdown library
ENV DISCOUNTVER 2.1.8a
ENV DISCOUNTURL http://www.pell.portland.or.us/~orc/Code/discount/discount-$DISCOUNTVER.tar.bz2
RUN wget $DISCOUNTURL && \
    tar jxf discount-$DISCOUNTVER.tar.bz2 && \
    rm discount-$DISCOUNTVER.tar.bz2 && \
    ln -sf discount-$DISCOUNTVER discount
WORKDIR $APPDIR/discount
RUN yum -y install gcc cloog-ppl cpp glibc-devel glibc-headers kernel-headers libgomp mpfr ppl && \
    ./configure.sh && \
    make && \
    make install && \
    yum remove -y gcc cloog-ppl cpp glibc-devel glibc-headers kernel-headers libgomp mpfr ppl && \
    yum clean all

# install pygments
RUN pip install pygments

# environment variables
ENV PATH ${PATH}:$APPDIR/bin
ENV RERUN_MODULES /usr/lib/rerun/modules
ENV RERUN_COLOR true

WORKDIR $APPDIR
VOLUME $APPDIR/modules

CMD []
