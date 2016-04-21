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
    dnf -y clean all && \
    gem install --no-document \
      haml-rails \
      bootstrap-sass \
      font-awesome-rails \
      font-ionicons-rails \
      fastclick-rails \
      jquery-datatables-rails \
    && :

CMD ["bash"]


ONBUILD ENV APP_PATH /opt/app
ONBUILD RUN mkdir -p $APP_PATH
ONBUILD WORKDIR $APP_PATH

ONBUILD COPY Gemfile $APP_PATH
ONBUILD COPY Gemfile.lock $APP_PATH
ONBUILD RUN bundle install --local

ONBUILD COPY . $APP_PATH

ONBUILD EXPOSE 3000
ONBUILD CMD ["rails", "server", "-b", "0.0.0.0"]
