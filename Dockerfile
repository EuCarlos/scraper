FROM ruby:2.7

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# CMD ["./app.rb"]
CMD ["ruby", "app.rb"]