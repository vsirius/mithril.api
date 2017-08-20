#!/bin/bash
export DB_HOST=postgresql
cd /work/
mix local.rebar --force
yes | mix deps.get 
CONTAINER_HTTP_HOST=mithril_api CONTAINER_HTTP_PORT=4000 mix test test/acceptance 
