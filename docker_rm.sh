#!/bin/bash

for i in `docker ps -a | awk '{print $1}'| grep -v 'CONTAINER'`; do docker rm -f $i; done

