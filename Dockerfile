FROM ubuntu as sqlite_wal2_amal

RUN apt update
RUN apt install -y curl build-essential

RUN mkdir /sqlite_src
RUN curl -L "https://www.sqlite.org/src/tarball/sqlite.tar.gz?r=wal2" | tar -zxf - --strip-components 1 -C /sqlite_src

WORKDIR /sqlite_src

ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y tcl-dev

RUN sh configure
RUN make sqlite3.c

RUN apt install -y zip

RUN zip -r ../sqlite.zip sqlite3.c shell.c sqlite3.h sqlite3ext.h VERSION
