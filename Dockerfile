FROM ubuntu:14.04.2
MAINTAINER Aleksey Laguta <laguta@ispras.ru>

ENV DEBIAN_FRONTEND=noninteractive
RUN \
  apt-get update && \
  apt-get -y install \
  build-essential \
  curl \
  libcurl4-openssl-dev \
  libc6-dev \
  libreadline-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  libyaml-dev \
  zlib1g-dev \
  libssl-dev 

# Ruby install
RUN \
  curl -- progress http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz | tar xz && \
  cd ruby-2.1.5 && \
  ./configure --disable-install-doc && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.1.5 && \
  echo 'gem: --no-document' > /usr/local/etc/gemrc && \
  gem install bundler 

# SqLite
RUN apt-get -y install sqlite3 libsqlite3-dev

# AnnotameLE
WORKDIR /var/www/annotamele
COPY lib/annotamele/foundation .
RUN \
  bundle install --without production --path vendor/bundle && \
  bundle exec rake db:create:all db:migrate db:seed 

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
