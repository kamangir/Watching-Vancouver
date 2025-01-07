from typing import List

from abcli.host import signature as abcli_signature

from vancouver_watching import fullname


def signature() -> List[str]:
    return [
        fullname(),
    ] + abcli_signature()
