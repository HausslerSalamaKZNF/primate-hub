from os import path as osp
import re
import glob
import pipettor
from contextlib import contextmanager
from pycbio.sys import fileOps
from pycbio.sys.symEnum import SymEnum, auto


class AssemblyType(SymEnum):
    database = auto()
    genark_hub = auto()
    curated_hub = auto()

def getSpecialDataDir(ucscSpec):
    "Were weird, handmade stuff is kept"
    return osp.join(osp.dirname(osp.dirname(osp.dirname(__file__))), 'data/special', ucscSpec)

def isHumanAsm(ucscSpec):
    "need to ignore alts"
    return ucscSpec == "hg38"

def getAssemblyType(ucscSpec):
    if ucscSpec.startswith("GCF_"):
        return AssemblyType.genark_hub
    elif ucscSpec == "hs1":
        return AssemblyType.curated_hub
    else:
        return AssemblyType.database

def isAltChrom(ucscSpec, chrom):
    if isHumanAsm(ucscSpec):
        return len(chrom) > 5
    else:
        return False

def genArkSplitAcc(ucscSpec):
    # GCF_006542625.1 -> GCF/006/542/625/GCF_006542625.1
    m = re.match("^(GCF)_([0-9]{3})([0-9]{3})([0-9]{3})\\.[0-9]+$", ucscSpec)
    if m is None:
        raise Exception(f"can't parse '{ucscSpec}'")
    return osp.join(*m.groups(), ucscSpec)

def genArkDataDir(ucscSpec):
    return osp.join("/hive/data/genomes/asmHubs", genArkSplitAcc(ucscSpec))

def genArkBuildDir(ucscSpec):
    """build directories have names like GCF_006542625.1_Asia_NLE_v1/"""
    buildRoot = "/hive/data/genomes/asmHubs/refseqBuild"
    dirglob = buildRoot + "/" + genArkSplitAcc(ucscSpec) + "_*"
    dirpaths = glob.glob(dirglob)
    if len(dirpaths) != 1:
        raise Exception(f"{len(dirpaths)} matches to {dirglob}: {dirpaths}")
    return dirpaths[0]

def genArkUglyName(ucscSpec):
    """like GCF_006542625.1_Asia_NLE_v1"""
    return osp.basename(genArkBuildDir(ucscSpec))

def getGenArkRefSeqPath(ucscSpec, what):
    # ugly names are like GCF_006542625.1_Asia_NLE_v1.ncbiRefSeqOther.bb
    uglyName = genArkUglyName(ucscSpec)
    return f"{genArkBuildDir(ucscSpec)}/trackData/ncbiRefSeq/{uglyName}.{what}"

def getCuratedHubRefSeqPath(ucscSpec, what):
    return f"/gbdb/{ucscSpec}/ncbiRefSeq/{what}"

def getGenomeTwoBit(ucscSpec):
    if getAssemblyType(ucscSpec) == AssemblyType.genark_hub:
        twoBit = osp.join(genArkDataDir(ucscSpec), ucscSpec + ".2bit")
    else:
        twoBit = f"/hive/data/genomes/{ucscSpec}/{ucscSpec}.2bit"
    if not osp.exists(twoBit):
        raise Exception(f"twoBit file not found for '{ucscSpec}': {twoBit}")
    return twoBit

def getGenomeOoc(ucscSpec):
    if ucscSpec == "GCF_006542625.1":
        ooc = osp.join(getSpecialDataDir(ucscSpec), ucscSpec + ".ooc")
    elif ucscSpec == "hs1":
        ooc = "/hive/data/genomes/asmHubs/genbankBuild/GCA/009/914/755/GCA_009914755.4_T2T-CHM13v2.0/trackData/blat.hg38.2022-04-09/GCA_009914755.4.11.ooc"
    else:
        ooc = f"/hive/data/genomes/{ucscSpec}/jkStuff/{ucscSpec}.11.ooc"
    if not osp.exists(ooc):
        raise Exception(f"OOC file for '{ucscSpec}' does not exist: {ooc}")
    return ooc

def getGenomeChromAlias(ucscSpec):
    if getAssemblyType(ucscSpec) in (AssemblyType.genark_hub, AssemblyType.curated_hub):
        return osp.join(getSpecialDataDir(ucscSpec), f"{ucscSpec}.chromAlias.tab")
    else:
        return f"/hive/data/genomes/{ucscSpec}/bed/chromAlias/{ucscSpec}.chromAlias.tab"

def getGenomeChroms(ucscSpec):
    with pipettor.Popen(["twoBitInfo", getGenomeTwoBit(ucscSpec), "/dev/stdout"]) as fh:
        return [r[0] for r in fileOps.iterRows(fh) if not isAltChrom(ucscSpec, r[0])]

@contextmanager
def ChromSizesTmp(ucscSpec):
    tmpSizesFile = fileOps.tmpFileGet("chromSizes")
    try:
        pipettor.run(["twoBitInfo", getGenomeTwoBit(ucscSpec), tmpSizesFile])
        yield tmpSizesFile
    finally:
        fileOps.rmFiles(tmpSizesFile)
