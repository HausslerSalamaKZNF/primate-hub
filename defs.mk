# include with
#   ROOT=../..
#   include ${ROOT}/defs.mk

.SECONDARY:

MAKEFLAGS = --no-builtin-rules
SHELL = /bin/bash -e

binDir = ${ROOT}/bin
libDir = ${ROOT}/lib

PYTHON = python3
export PYTHONPATH = ${libDir}

FLAKE8 = python3 -m flake8
PYTEST_FLAGS = -s -vv --tb=native
PYTEST = ${PYTHON} -m pytest ${PYTEST_FLAGS}

export PYTHONWARNINGS=always

diff = diff -u

tmpExt = $(shell hostname).$(shell echo $$PPID).tmp
tmpExtGz = ${tmpExt}.gz

pseudoPipeToBigBed = ${binDir}/pseudoPipeToBigBed
