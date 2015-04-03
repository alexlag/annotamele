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
  echo 'gem: --no-document' > ~/.gemrc && \
  gem install bundler 

# SqLite
RUN \
  apt-get -y install sqlite3 libsqlite3-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# AnnotameLE
WORKDIR /var/www/annotamele
COPY lib/annotamele/foundation .
COPY docker/answer_types.json config/answer_types.json
COPY docker/dataset.json db/seed_data.json
COPY lib/annotamele/foundation .
RUN \
  bundle install --without production --path vendor/bundle && \
  bundle exec rake db:create:all db:migrate db:seed 

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0"]