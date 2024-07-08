#!/bin/env bash
function _wrapper() {
    podman run --publish 8000:8000 --entrypoint /bin/bash --tty --interactive --rm --workdir /app --volume $(pwd):/app:rw --volume $(pwd)/src:/src:ro python:3.11.9-bookworm "${@}"
}
_wrapper "${@}"
