root = .
include ${root}/defs.mk


pyprogs = $(shell file -F $$'\t' bin/* | awk '/Python script/{print $$1}')
pylibs = $(wildcard lib/primatehub/*.py)

lint:
	${FLAKE8} --color=never ${pyprogs} ${pylibs}

test:
	cd tests && ${MAKE} test

clean:
	cd tests && ${MAKE} clean
	rm -rf ${binDir}/__pycache__ ${libDir}/__pycache__
