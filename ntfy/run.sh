#!/bin/bash

# Read TS_AUTHKEY
. .env

docker compose up -d --remove-orphans
