#!/bin/sh

for i in `docker images | awk '{print $3}' | grep -v IMAGE`; do
    docker rmi -f $i
done
