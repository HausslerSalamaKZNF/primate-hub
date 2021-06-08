
#hubDir = /public/groups/cgl/cat/primates_jason/REDO/cat/gencode_v33/out/assemblyHub
#hubUrl = http://courtyard.gi.ucsc.edu/~jcarmstr/cat_data/primates_jason/REDO/cat/gencode_v33/out/assemblyHub/hub.txt

hubDir = /hive/users/markd/kznf/projs/track-hub-work/track-hub
hubUrl = http://hgwdev.gi.ucsc.edu/~markd/kznf/track-hub/hub.txt 

assemblies = \
    Rhesus \
    Marmoset \
    Orangutan \
    Gorilla \
    Chimp \
    Bonobo \
    Human

srcs = $(wildcard *.html *.txt)
asmDir = ../asm-hub
asmSrcs = $(subst ${asmDir}/,,$(foreach a,${assemblies},$(wildcard ${asmDir}/$a/*.txt ${asmDir}/$a/*.html ${asmDir}/$a/*/*.txt ${asmDir}/$a/*/*.html)))

all: hub

hub: ${srcs:%=${hubDir}/%}  ${asmSrcs:%=${hubDir}/%}
	hubCheck ${hubUrl}

${hubDir}/%: %
	@mkdir -p $(dir $@)
	cp -f $< $@

${hubDir}/%: ${asmDir}/%
	@mkdir -p $(dir $@)
	cp -f $< $@
