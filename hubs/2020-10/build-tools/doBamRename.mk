

all: do_Chimp do_Bonobo do_Gorilla do_Orangutan do_Rhesus do_Marmoset


do_Bonobo:
	${MAKE} -f doBamRename.mk do_renames src=Bonobo dest=panPan3
do_Chimp:
	${MAKE} -f doBamRename.mk do_renames src=Chimp dest=panTro6
do_Gorilla:
	${MAKE} -f doBamRename.mk do_renames src=Gorilla dest=gorGor6
do_Marmoset:
	${MAKE} -f doBamRename.mk do_renames src=Marmoset dest=calJac4
do_Orangutan:
	${MAKE} -f doBamRename.mk do_renames src=Orangutan dest=ponAbe3
do_Rhesus:
	${MAKE} -f doBamRename.mk do_renames src=Rhesus dest=rheMac10


bbs = $(subst hub-in/,,$(wildcard hub-in/${src}/*.bam))

do_renames: ${bbs:%=hub-out/%}


hub-out/%: hub-in/%
	@mkdir -p $(dir $@)
	~/compbio/kznf/projs/primate-hub/bin/chromRenameBam $< mappings/${src}.mapping $@
