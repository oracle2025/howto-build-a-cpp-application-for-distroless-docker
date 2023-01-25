#!/bin/bash -ex
docker image inspect cpp-application-for-distroless-docker --format='{{.Size}}'
