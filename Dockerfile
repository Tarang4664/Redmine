FROM ruby:3.1.0-alpine
LABEL maintainer="ansibleteam@gmail.com"
RUN apk --update add build-base nodejs tzdata postgresql-dev postgresql-client libxslt-dev libxml2-dev imagemagick
RUN cd /opt
RUN mkdir redmine
WORKDIR /opt/redmine
COPY . .
ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV
RUN if [[ "$RAILS_ENV" == "production" ]]; then bundle install --without development test; else bundle install; fi
RUN bundle exec rake generate_secret_token
EXPOSE 3000
EXPOSE 5432:5432
CMD [ "rails","s","-e","production"]

