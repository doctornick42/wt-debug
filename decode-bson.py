#!/usr/bin/env python3

import sys
from bson import BSON
from pprint import pprint


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} HEX_STRING")
        sys.exit(1)

    try:
        data = bytes.fromhex(sys.argv[1])
        document = BSON(data).decode()
        pprint(document, sort_dicts=False)
    except ValueError as e:
        print(f"Invalid hex string: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Failed to decode BSON: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()