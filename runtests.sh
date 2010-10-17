#!/bin/bash
cd tests
echo "setting up test environment (this might take a while)..."
python bootstrap.py >/dev/null 2>&1
./bin/buildout >/dev/null 2>&1
echo "running tests"
HUDSON=0;
SUITE='cms'
if [ $1 ]; then
    if [ $1 == "--hudson" ]; then
        HUDSON=1
    else
        SUITE="cms.$1"
    fi
fi
if [ $HUDSON ]; then
    ./bin/django hudson $SUITE
    RETCODE=$?
else
    ./bin/django test $SUITE
    RETCODE=$?
fi
cd ..
echo "done"
exit $RETCODE