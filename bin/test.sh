#!/bin/bash
export DB_HOST=postgresql
cd /mithril.api/
mix local.hex --force
mix deps.get 
CONTAINER_HTTP_HOST=mithril_api CONTAINER_HTTP_PORT=4000 mix test test/acceptance 