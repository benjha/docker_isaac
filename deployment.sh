#!/bin/bash

oc new-build https://github.com/benjha/docker_isaac
oc create -f isaac_server_deployment.yaml

