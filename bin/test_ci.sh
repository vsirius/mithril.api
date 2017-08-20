#!/bin/bash
export DB_HOST=postgresql
cd /work/
mix local.rebar --force
yes | mix deps.get 
mix test --exclude pending --trace
mix coveralls.travis --exclude pending
mix credo --strict
mix dogma
