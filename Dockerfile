FROM ruby:2.5.3-slim
MAINTAINER Rasmus Kjellberg <rk@youngmedia.se>

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev mysql-client default-libmysqlclient-dev libsqlite3-dev --fix-missing --no-install-recommends
RUN gem install mysql2
RUN gem install rails

RUN mkdir -p /app
WORKDIR /app

RUN rails new . --force

ONBUILD RUN bundle install

VOLUME /app/public/assets

CMD bundle exec rails db:migrate && bundle exec puma -C config/puma.rb