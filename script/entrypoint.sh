#!/usr/bin/bash
  set -xeuo pipefail
  echo `export GEM_HOME=$HOME/.gem` >> $HOME/.bashrc
  ./script/wait-for-tcp.sh db 5433
  if [[ -f ./tmp/pids/server.pid ]]; then
    rm ./tmp/pids/server.pid
  fi
  bundle
  if ! [[ -f .db-created ]]; then
    rails db:drop db:create
    touch .db-created
  fi
  rails db:create
  rails db:migrate
  if ! [[ -f .db-seeded ]]; then
    rails db:seed
    touch .db-seeded
  fi
  bundle exec rails s -b '0.0.0.0'