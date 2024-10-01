FROM ruby:3.2.5-slim
WORKDIR "/app"

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl libjemalloc2 libvips libpq-dev postgresql-client git && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment
ENV RAILS_ENV="development" 

RUN gem install bundler

COPY Gemfile Gemfile.lock ./

ARG RAILS_ENV
ENV RACK_ENV='development'
RUN bundle install
