#
# new tracks are only being added to the trackHubs on top of the UCSC browser.
# These tracks are in ${asm}/trackDb.txt
# 
root = ../../..
include ../defs.mk

hub_dir = ${hubRootDir}/track-hub
hub_url = ${hubRootUrl}/track-hub/hub.txt
asm_hub_dir = ../asm-hub

gene_set_dir = ${hub_dir}/consensus_gene_set
gene_set_annot_types = gff3.gz gp.gz gtf.gz

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
###
# recursive: asm=
###
asm_hub_html = $(wildcard ${asm_hub_dir}/${asm}/*.html)
track_hub_html = $(wildcard ${asm}/*.html)
dest_html = $(subst ${asm_hub_dir}/,${hub_dir}/,${asm_hub_html}) ${track_hub_html:%=${hub_dir}/%}

# all trackDb dependencies these are combined and edits
asm_hub_txt = $(wildcard ${asm_hub_dir}/${asm}/*.txt)
track_hub_txt = $(wildcard ${asm}/*.txt) $(wildcard trackDb/*.txt)
ucsc_asm = ${ucsc_asm_${asm}}

src_trackdb = ${asm_hub_txt} ${track_hub_txt}

dest_trackdb = ${hub_dir}/${asm}/trackDb.txt

# Human does not have CAT
ifneq (${asm},Human)
    dest_ucsc_annot_files = ${gene_set_annot_types:%=${gene_set_dir}/${asm}.UCSC.%}
endif

build_asm: ${dest_html} ${dest_trackdb} ${dest_ucsc_annot_files}

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

# map files to UCSC chrom names
hgdownload = /data/apache/htdocs-hgdownload
ifeq (${asm},Gibbon)
    chromAlias = /hive/data/genomes/asmHubs/refseqBuild/GCF/006/542/625/GCF_006542625.1_Asia_NLE_v1/trackData/chromAlias/GCF_006542625.1_Asia_NLE_v1.chromAlias.txt
else
    chromAlias = ${hubRootDir}/track-hub/mappings/${asm}.mapping
endif

%/${asm}.UCSC.gff3.gz: %/${asm}.gff3.gz
	zcat $< | chromToUcsc --skipUnknown -k 1 -a ${chromAlias} | pigz -c >$@.tmp
	mv -f $@.tmp $@

%/${asm}.UCSC.gp.gz: %/${asm}.gp.gz
	zcat $< | chromToUcsc --skipUnknown -k 2 -a ${chromAlias} | pigz -c >$@.tmp
	mv -f $@.tmp $@

%/${asm}.UCSC.gtf.gz: %/${asm}.gtf.gz
	zcat $< | chromToUcsc --skipUnknown -k 1 -a ${chromAlias} | pigz -c >$@.tmp
	mv -f $@.tmp $@

clean_asm:
	rm -rf ${dest_html} ${dest_trackdb}


check_asm:
	hubCheck -genome=${ucsc_asm_${asm}} -udcDir=${udcDir} ${hub_url}


sync:
	cd ${hubRootDir} && rsync -av track-hub ${pub_hub_host}:${pub_hub_dir}
