#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/td/catkin_ws/src/exercises"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/td/catkin_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/td/catkin_ws/install/lib/python2.7/dist-packages:/home/td/catkin_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/td/catkin_ws/build" \
    "/usr/bin/python2" \
    "/home/td/catkin_ws/src/exercises/setup.py" \
     \
    build --build-base "/home/td/catkin_ws/build/exercises" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/td/catkin_ws/install" --install-scripts="/home/td/catkin_ws/install/bin"
