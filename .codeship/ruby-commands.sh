#!/usr/bin/env bash

source /app/.codeship/env

cd /app
bundle install
rake db:setup

rspec --format=progress
