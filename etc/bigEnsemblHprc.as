table bigEnsembl
"Ensembl gene models"
   (
   # bigGenePred
   string chrom;       "Reference sequence chromosome or scaffold"
   uint   chromStart;  "Start position in chromosome"
   uint   chromEnd;    "End position in chromosome"
   string name;        "transcript id with version"
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
   string geneName;    "Gene id with version"
   string geneName2;   "Gene symbol"
   string geneType;    "Gene type"

   # Standard additional Ensembl fields not in above fields
   string description;       "Gene description"
   int numTags;              "number of tags"
   string[numTags] tags;     "tags"

   # additional Ensembl HPRC columns
   string parentGene;        "Parent gene id used to create annotation"
   string parentTranscript;  "Parent transcript id used to create annotation"
   string 	annotationMethod;  "Annotation algorithm"
   float cdsCoverage;        "Percent of CDS that was mapped"
   uint cdsGap;              "Number of gaps in CDS"
   float cdsIdentity;        "Percent identity of CDS"
   float mappingCoverage;    "Percent of transcript that was mapped"
   float mappingIdentity;    "Percent identity of transcript"
   )


