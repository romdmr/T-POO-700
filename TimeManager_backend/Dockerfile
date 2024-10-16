FROM elixir:1.17.3-alpine

# Installer les dépendances système
RUN apk update && \
    apk add --no-cache build-base git postgresql-client postgresql-dev nodejs npm

WORKDIR /app

# Copier les fichiers mix.exs et mix.lock
COPY mix.exs mix.lock ./ 

# Installer Hex et Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Installer les dépendances Elixir
RUN mix deps.get

# Copier le reste de l'application
COPY . /app

# Vérifier les versions de mix, Node et npm
RUN mix --version && node --version && npm --version

EXPOSE 4000

