FROM ruby:2-alpine

MAINTAINER Fredy Muñoz <fredy@munoz.im>

COPY . .

RUN \

  # Install Alpine packages
  apk add --no-cache \
    sqlite \
    nodejs \
    tzdata \
    build-base \
    sqlite-dev \
    libxml2-dev \
    libxslt-dev \
    && \

  # Install gems specified in the provided Gemfile
  bundle install --no-cache && \

  # Remove dev packages
  # apk del \
  #   build-base \
  #   sqlite-dev \
  #   libxml2-dev \
  #   libxslt-dev \
  #   && \

  # Cleanup
  gem cleanup && \
  rm -rf \
    # Gemfile* \
    /usr/lib/ruby/gems/*/cache/* \
    && \

: # END RUN

CMD ["sh"]

ONBUILD ENV APP_PATH /opt/app
ONBUILD RUN mkdir -p $APP_PATH
ONBUILD COPY . $APP_PATH
ONBUILD WORKDIR $APP_PATH
ONBUILD RUN bundle install --local

ONBUILD EXPOSE 3000
ONBUILD CMD ["rails", "server", "-b", "0.0.0.0"]
