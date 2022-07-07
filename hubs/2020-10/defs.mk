
root = ../../..

.SECONDARY:

hostname = $(shell hostname)

buildDate = 2020-10

ifeq (${hostname},hgwdev)
   hubRootDir = /hive/users/markd/kznf/projs/primate-test-hub/2020-10
   hubRootUrl = http://hgwdev.gi.ucsc.edu/~markd/kznf/primate-test-hub/2020-10
else
   # linked locations:
   # /public/groups/cgl/cat/primates_jason/REDO/cat/gencode_v33/out/assemblyHub
   # http://courtyard.gi.ucsc.edu/~jcarmstr/cat_data/primates_jason/REDO/cat/gencode_v33/out/assemblyHub/hub.txt
   hubRootDir = /public/home/markd/public_html/primates-hubs/${buildDate}
   hubRootUrl = http://cgl.gi.ucsc.edu/~markd/primates-hubs/${buildDate}
endif


udcDir = ${TMPDIR}/markd/udcCache

