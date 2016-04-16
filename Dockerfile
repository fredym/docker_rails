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
      rubygem-haml-rails \
      rubygem-bootstrap-sass \
      rubygem-font-awesome-rails \
      && \
    dnf -y clean all && \
    gem install \
      font-ionicons-rails \
      fastclick-rails \
      jquery-slimscroll-rails

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


# References and credits
# ----------------------
# https://developer.fedoraproject.org/tech/languages/ruby/ror-installation.html
# https://fedoraproject.org/wiki/Changes/Ruby_on_Rails_4.2
# https://fedoraproject.org/wiki/Ruby_SIG
# https://github.com/docker-library/rails/blob/9df9b5e6b1519faf22e1565c2caaebf7cc1c665b/onbuild/Dockerfile
