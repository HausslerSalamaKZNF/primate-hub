#
# new tracks are only being added to the trackHubs on top of the UCSC browser.
# These tracks are in ${asm}/trackDb.txt
# 
root = ../../..
include ../defs.mk

hub_dir = ${hubRootDir}/track-hub
hub_url = ${hubRootUrl}/track-hub/hub.txt
asm_hub_dir = ../asm-hub


top_srcs = $(wildcard *.html *.txt html/*.html)
top_dests = ${top_srcs:%=${hub_dir}/%}

all: build

build: ${top_dests} build_asms
	${MAKE} check

build_asms: ${assemblies:%=build_asm_%}
build_asm_%:
	${MAKE} build_asm asm=$*

check: ${assemblies:%=check_asm_%}
check_asm_%:
	${MAKE} check_asm asm=$*

clean: ${assemblies:%=clean_asm_%}
	rm -f ${top_dests}
clean_asm_%:
	${MAKE} clean_asm asm=$*

# recursive: asm=
asm_hub_html = $(wildcard ${asm_hub_dir}/${asm}/*.html)
track_hub_html = $(wildcard ${asm}/*.html)
dest_html = $(subst ${asm_hub_dir}/,${hub_dir}/,${asm_hub_html}) ${track_hub_html:%=${hub_dir}/%}

# all trackDb dependencies these are combined and edits
asm_hub_txt = $(wildcard ${asm_hub_dir}/${asm}/*.txt)
track_hub_txt = $(wildcard ${asm}/*.txt) $(wildcard trackDb/*.txt)

src_trackdb = ${asm_hub_txt} ${track_hub_txt}

dest_trackdb = ${hub_dir}/${asm}/trackDb.txt

build_asm: ${dest_html} ${dest_trackdb}

asmSrcs = $(subst ${asm_hub_dir}/,,$(foreach a,${assemblies},$(wildcard ${asm_hub_dir}/$a/*.txt ${asm_hub_dir}/$a/*.html ${asm_hub_dir}/$a/*/*.txt ${asm_hub_dir}/$a/*/*.html)))

${hub_dir}/%: %
	@mkdir -p $(dir $@)
	cp -f $< $@
${hub_dir}/%: ${asm_hub_dir}/%
	@mkdir -p $(dir $@)
	cp -f $< $@

${dest_trackdb}: ${src_trackdb} ./editTrackDb
	@mkdir -p $(dir $@)
	./editTrackDb --out=$@.tmp ${asm_hub_dir}/${asm}/trackDb.txt ${asm}/trackDb.txt
	mv -f $@.tmp $@

clean_asm:
	rm -rf ${dest_html} ${dest_trackdb}


check_asm:
	hubCheck -genome=${ucsc_asm_${asm}} -udcDir=${udcDir} ${hub_url}


sync:
	cd ${hubRootDir} && rsync -av track-hub ${pub_hub_host}:${pub_hub_dir}
