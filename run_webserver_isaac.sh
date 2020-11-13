#!/bin/bash

httpd -DFOREGROUND &> webserver.log  &
sleep 3

isaac &> isaac.log
