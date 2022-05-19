#
# new tracks are only being added to the trackHubs on top of the UCSC browser.
# These tracks are in ${asm}/trackDb.txt
# 
root = ../../..
include ../defs.mk

hubDir = ${hubRootDir}/track-hub
hubUrl = ${hubRootUrl}/track-hub/hub.txt

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
