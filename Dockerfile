FROM alpine:3.3

MAINTAINER Fredy Muñoz <fredy@munoz.im>

COPY . .

RUN \

  # Install Alpine packages
  apk add --no-cache \
    ruby-rails4.2 \
    ruby-io-console \
    ruby-sqlite \
    sqlite \
    nodejs \
    build-base \
    ruby-dev \
    && \

  # Install gems specified in the provided Gemfile
  bundle install --no-cache && \

  # Remove dev packages
  apk del \
    build-base \
    ruby-dev \
    && \

  # Cleanup
  gem cleanup && \
  rm -rf \
    Gemfile* \
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
