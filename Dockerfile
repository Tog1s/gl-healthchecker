FROM ruby:2.7.1
WORKDIR /app
ADD . /app
RUN gem install bundler && bundle install
ENTRYPOINT ["ruby main.rb"]
