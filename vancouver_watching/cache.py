import argparse
from blueness import module
from vancouver_watching import NAME, VERSION
from vancouver_watching.logger import logger
from vancouver_watching.QGIS import update_cache
from blueness.argparse.generic import sys_exit

NAME = module.name(__file__, NAME)

parser = argparse.ArgumentParser(NAME, description=f"{NAME}-{VERSION}")
parser.add_argument(
    "task",
    type=str,
    help="update",
)
parser.add_argument(
    "--object_name",
    type=str,
    default=".",
)
parser.add_argument(
    "--verbose",
    type=int,
    default=0,
    help="0|1",
)
args = parser.parse_args()

success = False
if args.task == "update":
    success, _ = update_cache(
        object_name=args.object_name,
        verbose=args.verbose,
    )
else:
    success = None

sys_exit(logger, NAME, args.task, success)