
hostname = $(shell hostname)

udcDir = ${TMPDIR}/markd/udcCache

ifeq (${hostname},hgwdev)
   hubDir = /hive/users/markd/kznf/projs/track-hub-work/track-hub
   hubUrl = http://hgwdev.gi.ucsc.edu/~markd/kznf/track-hub/hub.txt 
else
   hubDir = /public/home/markd/public_html/primates-hubs/2020-10/track-hub
   hubUrl = http://cgl.gi.ucsc.edu/~markd/primates-hubs/2020-10/track-hub/hub.txt
endif

assemblies = \
    Rhesus \
    Marmoset \
    Orangutan \
    Gorilla \
    Chimp \
    Bonobo \
    Human \
    Gibbon

srcs = $(wildcard *.html *.txt)
asmDir = ../asm-hub
asmSrcs = $(subst ${asmDir}/,,$(foreach a,${assemblies},$(wildcard ${asmDir}/$a/*.txt ${asmDir}/$a/*.html ${asmDir}/$a/*/*.txt ${asmDir}/$a/*/*.html)))

all: hub

hub: ${srcs:%=${hubDir}/%}  ${asmSrcs:%=${hubDir}/%}
	hubCheck -udcDir=${udcDir} ${hubUrl}

${hubDir}/%: %
	@mkdir -p $(dir $@)
	cp -f $< $@

${hubDir}/%/trackDb.txt: ${asmDir}/%/trackDb.txt
	@mkdir -p $(dir $@)
	./editTrackDb $< $@.tmp
	mv -f $@.tmp $@

${hubDir}/%: ${asmDir}/%
	@mkdir -p $(dir $@)
	cp -f $< $@
