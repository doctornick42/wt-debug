#!/bin/bash

set -e

mkdir -p /data/db

exec mongod \
    --dbpath /data/db \
    --bind_ip_all