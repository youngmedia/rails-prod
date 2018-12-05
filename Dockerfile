FROM ruby:2.5.3-slim
MAINTAINER Rasmus Kjellberg <rk@youngmedia.se>

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev mysql-client default-libmysqlclient-dev libsqlite3-dev --fix-missing --no-install-recommends
RUN gem install mysql2
RUN gem install rails

RUN mkdir -p /app
WORKDIR /app

COPY build.sh /usr/bin/build-rails
RUN chmod +x /usr/bin/build-rails

RUN rails new . --force

ONBUILD RUN bundle install
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]