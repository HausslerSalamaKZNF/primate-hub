ROOT=..
include ${ROOT}/defs.mk

.SECONDARY:

ncbiGeneDb = ${HOME}/hive/NCBI-SqlLite/full/ncbiGene.db

test: pseudoPipeTests liftoffTests


pseudoPipeTests: testPpipeHashTsv testPpipeTabId

testPpipeHashTsv: mkout
	${pseudoPipeToBigBed} --ncbiGeneDb=${ncbiGeneDb} hash_tsv panPan3 input/Pan_paniscus_refseq_pgene.txt output/$@.bb
	bigBedToBed output/$@.bb output/$@.bed
	diff expected/$@.bed output/$@.bed

testPpipeTabId: mkout
	${pseudoPipeToBigBed} --chromAlias=/hive/data/genomes/hg38/bed/chromAlias/hg38.chromAlias.tab tab_with_id hg38 input/Human90.txt output/$@.bb
	bigBedToBed output/$@.bb output/$@.bed
	diff expected/$@.bed output/$@.bed

liftoffTests: testLiftoffCnv

testLiftoffCnv: mkout
	${liftoffToBigBed} panTro6 input/gencodeV41.Chimp.mapped.gff3 output/$@.bb
	bigBedToBed -header output/$@.bb output/$@.bed
	diff expected/$@.bed output/$@.bed

mkout:
	@mkdir -p output

clean:
	rm -rf output
