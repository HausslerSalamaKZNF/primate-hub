table bigLiftoff
"ligtoff gene models"
   (
   string chrom;       "Reference sequence chromosome or scaffold"
   uint   chromStart;  "Start position in chromosome"
   uint   chromEnd;    "End position in chromosome"
   string name;        "transcript id"
   uint score;         "Score (0-1000)"
   char[1] strand;     "+ or - for strand"
   uint thickStart;    "Start of where display should be thick (start codon)"
   uint thickEnd;      "End of where display should be thick (stop codon)"
   uint reserved;       "RGB value (use R,G,B string in input file)"
   int blockCount;     "Number of blocks"
   int[blockCount] blockSizes; "Comma separated list of block sizes"
   int[blockCount] chromStarts; "Start positions relative to chromStart"
   string name2;       "Gene symbol"
   string cdsStartStat; "Status of CDS start annotation (none, unknown, incomplete, or complete)"
   string cdsEndStat;   "Status of CDS end annotation (none, unknown, incomplete, or complete)"
   int[blockCount] exonFrames; "Exon frame {0,1,2}, or -1 if no frame for exon"
   string type;        "Transcript type"
   string geneName;    "Primary identifier for gene"
   string geneName2;   "gene Symbol"
   string geneType;    "Gene type"

   # GENCODE
   int numTags;              "number of tags"
   string[numTags] tags;     "tags"

   # from liftoff GFF3
   string geneSrcId;          "gene source id, less copy number modifier"
   string transcriptSrcId;    "transcript source id, less copy number modifier"
   float gene_coverage;       "percent coverage of gene"
   float gene_sequence_ID;    "sequence identity of gene"
   string gene_low_identity;  "is gene low identigy?"
   string gene_partial_mapping;  "is gene partially mapped?"
   int gene_extra_copy_number;   "extra_copy_number of gene"
   int gene_valid_ORFs;          "number of valid ORFs in the gene"
   int extra_copy_number;        "extra_copy_number of transcript"
   string valid_ORF;               "CDS annotation is valid "
   string matches_ref_protein;     "translated CDS matches the reference CDS exactly"
   string missing_start_codon;     "CDS does not begin with a start codon"
   string missing_stop_codon;      "CDS does not end with a stop codon"
   string inframe_stop_codon;      "CDS has an inframe stop codon. 
   )

