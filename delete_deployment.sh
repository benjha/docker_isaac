#!/bin/bash


oc delete deployment isaac-server
oc delete buildconfig dockerisaac
oc delete imagestream dockerisaac
#oc delete imagestream centos
