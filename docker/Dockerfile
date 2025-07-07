FROM ruby:3.1

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm && \
    npm install -g yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Railsのインストール
RUN gem install rails

CMD ["rails", "server", "-b", "0.0.0.0"]
