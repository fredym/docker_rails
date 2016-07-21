FROM alpine:3.3

MAINTAINER Fredy Muñoz <fredy@munoz.im>

RUN \

  # Install Alpine packages
  apk add --no-cache \
    build-base \
    sqlite \
    ruby-dev \
    ruby-rails4.2 \
    ruby-jquery-rails4.2 \
    ruby-sqlite \
    && \

  # Install gems
  gem install --no-document \
    coffee-rails \
    sass-rails \
    uglifier \
    turbolinks \
    jbuilder \
    therubyracer \
    sdoc \
    spring \
    byebug \
    web-console \
    haml-rails \
    bootstrap-sass \
    font-awesome-rails \
    font-ionicons-rails \
    fastclick-rails \
    jquery-datatables-rails \
    select2-rails \
    bootstrap-datepicker-rails \
    jquery-ui-rails \
    bootstrap-wysihtml5-rails \
    momentjs-rails \
    bootstrap-daterangepicker-rails \
    && \

  # Remove dev packages
  apk del \
    build-base \
    ruby-dev \
    && \

  # Cleanup
  rm -rf \
    /var/cache/apk/* \
    /usr/lib/ruby/gems/*/cache/* \
    ~/.gem \
    && \

  :

CMD ["sh"]

ONBUILD ENV APP_PATH /opt/app
ONBUILD RUN mkdir -p $APP_PATH
ONBUILD COPY . $APP_PATH
ONBUILD WORKDIR $APP_PATH
ONBUILD RUN bundle install --local

ONBUILD EXPOSE 3000
ONBUILD CMD ["rails", "server", "-b", "0.0.0.0"]
