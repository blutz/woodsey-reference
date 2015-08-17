FROM ruby:2.2.0
MAINTAINER Byron Lutz <byronlutz@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /woodsey-reference
WORKDIR /woodsey-reference
ADD Gemfile /woodsey-reference/Gemfile
RUN bundle install
ADD . /woodsey-reference
