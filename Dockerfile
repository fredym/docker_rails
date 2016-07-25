FROM fedora

MAINTAINER Fredy Muñoz <fredy@munoz.im>

RUN dnf -y install \
      ruby \
      sqlite \
      rubygem-rails \
      rubygem-sqlite3 \
      rubygem-coffee-rails \
      rubygem-sass-rails \
      rubygem-uglifier \
      rubygem-jquery-rails \
      rubygem-turbolinks \
      rubygem-jbuilder \
      rubygem-therubyracer \
      rubygem-sdoc \
      rubygem-spring \
      rubygem-byebug \
      rubygem-web-console \
      && \
    dnf -y clean all

CMD ["rails"]


ONBUILD ENV APP_PATH /opt/app
ONBUILD RUN mkdir -p $APP_PATH
ONBUILD WORKDIR $APP_PATH

ONBUILD COPY Gemfile $APP_PATH
ONBUILD COPY Gemfile.lock $APP_PATH
ONBUILD RUN bundle install

ONBUILD COPY . $APP_PATH

ONBUILD EXPOSE 3000
ONBUILD CMD ["bin/rails", "server", "-b", "0.0.0.0"]
