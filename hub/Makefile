
hubDir = /public/groups/cgl/cat/primates_jason/REDO/cat/gencode_v33/out/assemblyHub
hubUrl = http://courtyard.gi.ucsc.edu/~jcarmstr/cat_data/primates_jason/REDO/cat/gencode_v33/out/assemblyHub/hub.txt
blatHost = hgwdev.gi.ucsc.edu
blatPort = 4040
blatHubRelDir = weblab/primate.2020-10-14

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
	@echo "WARNING: hub check skipped for now due to non-compliant hub"
	#hubCheck ${hubUrl}

${hubDir}/genomes.txt: genomes.txt
	@mkdir -p $(dir $@)
	../bin/editHubGenomes -v blatHost=${blatHost} -v blatPort=${blatPort} -v blatHubRelDir=${blatHubRelDir} $< > $@.tmp
	mv -f $@.tmp $@

${hubDir}/%: %
	@mkdir -p $(dir $@)
	cp -f $< $@
