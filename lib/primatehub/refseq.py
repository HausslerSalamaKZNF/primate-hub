# RefSeq related stuff
import re

def isAntiSenseSymbol(geneName):
    return re.search('-AS[0-9]+$', geneName) is not None

def isZnfSymbol(geneName):
    """Check HUGO gene names to see if they look like a ZNF (ZNF285, ZNF286A),
    ZNF pseduo (ZNF252P, ZNF285CP), read-throughs (ZNF286A-TBC1D26)l and
    non-coding (ZNF222-DT).  Also handles other know related ZNG genes.
    Anti-sense (ZNF277-AS1) are ignored.
    """
    # see tests for weird cases
    # - is for readthroughs that combine symbols as well as lncRNA extensions
    if isAntiSenseSymbol(geneName):
        return False
    elif re.search("(^|-)ZNF[A-Z]?[0-9]+(($|-)|([A-Z]+[A-Z0-9]*($|-)))", geneName, flags=re.IGNORECASE) is not None:
        return True
    elif geneName.startswith("ZKSCAN") or (geneName == "RBAK"):
        return True
    else:
        return False


def _parseZnfDescription(geneName, description):
    def _pseudo_suffix():
        return "-pseudo" if description.find('pseudogene') >= 0 else ""

    # zinc finger protein 354A-like
    m = re.match('^zinc finger protein ([0-9A-Z]+)-like', description)
    if m is not None:
        return "ZNF" + m.group(1) + "-like" + _pseudo_suffix()

    # zinc finger protein 593
    # zinc finger protein 64 pseudogene
    # zinc finger protein 436, transcript variant X1
    # putative zinc finger protein 812, transcript variant X2
    m = re.search('zinc finger protein ([0-9A-Z]+)( |,|$)', description)
    if m is not None:
        return "ZNF" + m.group(1) + _pseudo_suffix()

    # zinc finger with KRAB and SCAN domains 5
    m = re.search("zinc finger with KRAB and SCAN.*", description)
    if m is not None:
        return "KZNF-other" + _pseudo_suffix()

    m = re.match("^zinc finger protein", description)
    if m is not None:
        return "ZNF-other" + _pseudo_suffix()

    return None

def refseqParseZnfSymbol(geneName, description=None):
    """Get a ZNF symbol, normalize to HGNC all-caps form.

    If the description is supplied, it is a RefSeq descriotion
    geneName is not a ZNF match, check the description.  Possible
    creating fake ZNF geneName.

    Example descriptions

       ZNF436	     zinc finger protein 436
       LOC100588975  zinc finger protein 436-like
       ZNF436        zinc finger protein 436, transcript variant X1 [from product]
       ZNF593:       zinc finger protein 593
       LOC100602456  zinc finger protein ubi-d4 pseudogene
       LOC100602735  zinc finger protein OZF-like
       ZKSCAN2       zinc finger with KRAB and SCAN domains 2
       LOC101179508  zinc finger protein 354A-like
       LOC100579608  zinc finger protein 64 pseudogene
       ZNF788P       zinc finger family member 788, pseudogene
       RBAK          RB associated KRAB zinc finger
       ZKSCAN5       zinc finger with KRAB and SCAN domains 5
       LOC100601770  zinc finger protein with KRAB and SCAN domains 8-like
       LOC100588975  zinc finger protein 436-like

    Return None if not a ZNF.
    """
    geneName = geneName.upper()
    if isZnfSymbol(geneName):
        return geneName
    elif description is not None:
        return _parseZnfDescription(geneName, description)
    else:
        return None
