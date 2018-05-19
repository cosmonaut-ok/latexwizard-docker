#!/bin/sh


if [ "$1" == "--update" ]; then
    shift
    docker pull cosmonaut/latexwizard
fi

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

# xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH "${PWD}":/home -w /home -e XAUTHORITY=$XAUTH cosmonaut/latexwizard $@
