#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

docker run \
  -v "$SCRIPT_DIR":/etc/ntfy \
  -p 8282:80 \
  -it \
  binwiederhier/ntfy \
  serve
