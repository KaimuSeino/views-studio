FROM ruby:3.1
WORKDIR /app
COPY . .
RUN gem install rails
CMD ["rails", "server", "-b", "0.0.0.0"]
