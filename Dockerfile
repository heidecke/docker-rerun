# vim:set ft=dockerfile:

FROM centos:6
MAINTAINER Luke Heidecke <luke@solinea.com>

ENV RERUNVER=1.3.4-1.el6
ENV DISCOUNTVER=2.1.8a
ENV PYGMENTSVER=2.0.2

ENV APPDIR /app
WORKDIR $APPDIR

RUN yum -y install \
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
#RUN rpm -Uvh http://dl.bintray.com/rerun/rerun-rpm/rerun-$RERUNVER.noarch.rpm

# install rerun from https://github.com/shlomoswidler/rerun for testing
RUN git clone git@github.com:shlomoswidler/rerun.git && \
    ln -sf $APPDIR/rerun/rerun $APPDIR/bin/rerun

# compile and install discount markdown library
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
RUN pip install pygments==$PYGMENTSVER

# environment variables
ENV PATH ${PATH}:$APPDIR/bin
ENV RERUN_MODULES $APPDIR/rerun/modules:$APPDIR/modules
ENV RERUN_COLOR true

WORKDIR $APPDIR
VOLUME $APPDIR/modules

ADD entrypoint.sh $APPDIR/

ENTRYPOINT ["./entrypoint.sh"]

CMD ["-v"]
