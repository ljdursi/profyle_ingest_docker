FROM ubuntu:17.04
MAINTAINER Jonathan Dursi <jonathan@dursi.ca>
LABEL Description="Start up a GA4GH server against a directory of PROFYLE metadata"

RUN apt-get update \
    && apt-get install -y \
        git \
        libcurl4-openssl-dev \
        libffi-dev \
        libssl-dev \
        libxslt1-dev \
        python-dev \
        python-pip \
        samtools \
        tabix \
        unzip \
        wget \
        zlib1g-dev 

RUN pip install git+https://github.com/CanDIG/ga4gh-schemas.git@experiment#egg=ga4gh_schemas \
    && pip install git+https://github.com/CanDIG/ga4gh-client.git@experiment#egg=ga4gh_client \
    && pip install git+https://github.com/CanDIG/ga4gh-server.git@experiment#egg=ga4gh_server \
    && pip install git+https://github.com/CanDIG/PROFYLE_ingest.git 

# work around broken ga4gh config in master
RUN mkdir -p /srv/ga4gh/ga4gh/server/templates/ \
    && touch /srv/ga4gh/ga4gh/server/templates/initial_peers.txt

# copy run scripts
COPY scripts/* /usr/local/bin/

## fix security issues w/ bash 4.4-ubuntu1
RUN apt-get install --only-upgrade bash

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/wrapper.sh"]
