FROM fedora:24

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
      rubygem-bcrypt \
      && \
    dnf -y clean all

CMD ["rails"]
