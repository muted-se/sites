#!/bin/env bash
## Wrapper

podman run --tty --interactive --rm --workdir /tmp --volume $(pwd):/tmp node:lts-bookworm-slim "${@}"

