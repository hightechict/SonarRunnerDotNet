#!/bin/bash
if ! start.sh;    then exit $?; fi
if ! restore.sh; then exit $?; fi
if ! build.sh;   then exit $?; fi
if ! test.sh;    then exit $?; fi
if ! end.sh;  then exit $?; fi