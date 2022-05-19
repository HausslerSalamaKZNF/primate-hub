root = ../../..
include ../defs.mk


hubDir = ${hubRootDir}/asm-hub
hubUrl = ${hubRootUrl}/asm-hub/hub.txt

blatHost = hgwdev.gi.ucsc.edu
blatPort = 4040
blatHubRelDir = weblab/primate.2020-10-14
editHubGenomes = ../../../bin/editHubGenomes 

assemblies = \
    primate \
    platyrrhini \
    hylobatidae \
    Rhesus \
    Owl_monkey \
    Marmoset \
    hominidae \
    Gibbon \
    human_chimp_bonobo_gorilla \
    Orangutan \
    human_chimp_bonobo \
    Gorilla \
    chimp_bonobo \
    Chimp \
    Bonobo \
    Human

srcs = $(wildcard *.html *.txt) $(foreach a,${assemblies},$(wildcard $a/*.txt $a/*.html $a/*/*.txt $a/*/*.html))

all: hub

hub: ${srcs:%=${hubDir}/%}
	${MAKE} hubChecks

hubChecks: ${assemblies:%=%_hubCheck}

%_hubCheck:
	hubCheck -genome=$* -udcDir=${udcDir} ${hubUrl}

${hubDir}/genomes.txt: genomes.txt
	@mkdir -p $(dir $@)
	${editHubGenomes} -v blatHost=${blatHost} -v blatPort=${blatPort} -v blatHubRelDir=${blatHubRelDir} $< > $@.tmp
	mv -f $@.tmp $@

${hubDir}/%: %
	@mkdir -p $(dir $@)
	cp -f $< $@

