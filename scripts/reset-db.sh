#!/bin/bash

docker compose down

rm -rf data/*

docker compose up -d

docker exec mongo-lab mongosh /init.js