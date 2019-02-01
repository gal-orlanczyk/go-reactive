#!/bin/bash

set -euo pipefail

jazzy \
    --clean \
    --readme README.md \
    --podspec GoReactive.podspec \
    --exclude=/*/Example/* \
    --output docs/