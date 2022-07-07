#!/bin/bash -ex

mkBigBed() {
    local tab=$1
    local seqs=$2
    local outdir=$(dirname $tab)
    local bb=${outdir}/$(basename $tab .tab).bb
    local log=${outdir}/$(basename $tab .tab).log
    ../../../bin/buildBigBed --as=${HOME}/kent/src/hg/lib/genomicSuperDups.as  --extraIndex=name \
                             bed6+23 $seqs $bb.tmp  $tab >& $log
    mv -f $bb.tmp $bb
}

mkBigBed Bonobo/GenomicSuperDup.tab     /hive/data/genomes/panPan3/panPan3.2bit &
mkBigBed Chimp/GenomicSuperDup.tab      /hive/data/genomes/panTro6/panTro6.2bit &
mkBigBed Gibbon/GenomicSuperDup.tab     https://hgdownload.soe.ucsc.edu/hubs/GCF/006/542/625/GCF_006542625.1/GCF_006542625.1.2bit &
mkBigBed Gorilla/GenomicSuperDup.tab    /hive/data/genomes/gorGor6/gorGor6.2bit &
mkBigBed Marmoset/GenomicSuperDup.tab   /hive/data/genomes/calJac4/calJac4.2bit &
mkBigBed Orangutan/GenomicSuperDup.tab  /hive/data/genomes/ponAbe3/ponAbe3.2bit &
mkBigBed Rhesus/GenomicSuperDup.tab     /hive/data/genomes/rheMac10/rheMac10.2bit &

wait
 
