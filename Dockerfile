FROM alpine:latest

MAINTAINER OSO DevOps (https://github.com/osodevops)

RUN apk add --update git

#force fresh git clone each build.
ADD https://api.github.com/repos/sullo/nikto/git/refs/heads/master version.json
RUN mkdir /source /nikto && cd /source && git clone https://github.com/sullo/nikto.git

RUN mv /source/nikto/program/* /nikto/

ENV PATH="/nikto:${PATH}"

RUN echo 'Selecting packages to Nikto.' \
  && apk update \
  && apk add --no-cache --virtual .build-deps \
     perl \
     perl-net-ssleay \
  && echo 'Cleaning cache from APK.' \
  && rm -rf /var/cache/apk/* \
  && echo 'Creating the nikto group.' \
  && addgroup nikto \
  && echo 'Creating the user nikto.' \
  && adduser -G nikto -g "Nikto user" -s /bin/sh -D nikto \
  && echo 'Changing the ownership.' \
  && chown -R nikto.nikto /nikto \
  && echo 'Creating a random password for root.' \
  && export RANDOM_PASSWORD=`tr -dc A-Za-z0-9 < /dev/urandom | head -c44` \
  && echo "root:$RANDOM_PASSWORD" | chpasswd \
  && unset RANDOM_PASSWORD \
  && echo 'Locking root account.' \
  && passwd -l root \
  && echo 'Finishing image.'

USER nikto

ENTRYPOINT ["nikto.pl"]