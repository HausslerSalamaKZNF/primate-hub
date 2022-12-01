ROOT = ../../..
include ${ROOT}/defs.mk
include ${ROOT}/hubs/2020-10/defs.mk

liftoff_gencode_orgs = Bonobo Chimp Gibbon Gorilla Marmoset Orangutan Rhesus chm13

tmpDir = tmp
humanFa = ${tmpDir}/Human.fa
gencodeGff3 = /hive/data/genomes/hg38/bed/gencodeV41/hgcImport/data/release_41/gencode.v41.annotation.gff3.gz
gencodeDb = ${tmpDir}/gencodeV41.db

all: doRunLiftoff doBuildTracks

doRunLiftoff: ${liftoff_gencode_orgs:%=%_runLiftoff}

%_runLiftoff: ${humanFa} ${gencodeDb}
	${MAKE} runLiftoff org=$*


destFa = ${tmpDir}/${org}.fa
intermediateDir = ${tmpDir}/${org}.inter

liftoffGencodeGff = liftoff/${org}/gencodeV41.${org}.mapped.gff3.gz
liftoffGencodeOrigGff = liftoff/${org}/gencodeV41.${org}.mapped.orig.gff3.gz
liftoffGencodeUnmapped = liftoff/${org}/gencodeV41.${org}.unmapped.ids

runLiftoff: ${liftoffGencodeGff}

${liftoffGencodeGff}: ${gencodeDb} ${destFa}
	@mkdir -p $(dir $@)
	liftoff -polish -copies -sc 0.85 -db ${gencodeDb} -o $@.orig.tmp.gff3 -u ${liftoffGencodeUnmapped} -dir ${intermediateDir} ${destFa} ${humanFa}
	${fakeGff3Phase} $@.orig.tmp.gff3_polished /dev/stdout | pigz -c >$@.tmp
	pigz -c < $@.orig.tmp.gff3 > ${liftoffGencodeOrigGff}
	rm $@.orig.tmp.gff3 $@.orig.tmp.gff3_polished
	mv -f $@.tmp $@

${gencodeDb}: ${gencodeGff3}
	@mkdir -p $(dir $@)
	gffutils-cli create --output $@.tmp $<
	mv -f $@.tmp $@

${tmpDir}/%.fa:
	@mkdir -p $(dir $@)
	twoBitToFa $$(${getTwoBitFile} ${ucsc_asm_$*}) $@.tmp
	samtools faidx $@.tmp
	mv -f $@.tmp.fai $@.fai
	mv -f $@.tmp $@

# build tracks

doBuildTracks: ${liftoff_gencode_orgs:%=%_buildTrack}

%_buildTrack: | doRunLiftoff
	${MAKE} builtTrack org=$*

liftoffBigBed = gencodeV41.liftoff.bb
trackDataOrgDir = ../track-hub/${org}
liftoffMainBigBed =  ../track-hub/${org}/${liftoffBigBed}
liftoffHubBigBed = ${hubRootDir}/track-hub/${org}/${liftoffBigBed}


builtTrack: ${liftoffMainBigBed} ${liftoffHubBigBed}

${liftoffMainBigBed}: ${liftoffGencodeGff} ${liftoffToBigBed} ${ROOT}/etc/liftoff.as
	${liftoffToBigBed} ${ucsc_asm_${org}} ${liftoffGencodeGff} $@

${liftoffHubBigBed}: ${liftoffMainBigBed}
	ln -f $< $@
