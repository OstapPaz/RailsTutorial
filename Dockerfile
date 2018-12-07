FROM ruby:2.5

RUN apt-get update

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get install -y nodejs
RUN apt-get update && apt-get install yarn

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /home/opazyniuk/RubymineProjects/RailsTutorial-master

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["puma", "-e", "development"]
#RUN apk add --update build-base postgresql-dev tzdata

