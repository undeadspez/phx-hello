FROM elixir:1.9

ENV BUILD_PACKAGES libpq-dev \
                   build-essential \
                   inotify-tools \
                   erlang-dev \
                   erlang-parsetools \
                   apt-transport-https \
                   ca-certificates

RUN apt-get update -qq && \
    apt-get install -y ${BUILD_PACKAGES}

RUN apt-get update && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update &&  apt-get install --no-install-recommends yarn

RUN mix local.hex --force && mix local.rebar --force

RUN mix archive.install hex phx_new 1.4.0 --force

RUN curl -sL https://deb.nodesource.com/setup_11.x \
    | bash - && apt-get install -y nodejs

WORKDIR /usr/src/app
