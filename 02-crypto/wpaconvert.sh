#!/usr/bin/env python3
import argparse
import base64
import re
import sys
from pathlib import Path


def extract_blocks(text: str):
    return re.findall(r"network=\{(.*?)\}", text, re.S)


def convert_block(block: str):
    ssid_match = re.search(r'ssid="([^"]+)"', block)
    psk_match = re.search(r'psk=([0-9a-fA-F]{64})', block)

    if not (ssid_match and psk_match):
        return None

    ssid = ssid_match.group(1).encode("utf-8")
    pmk = bytes.fromhex(psk_match.group(1))

    ssid_b64 = base64.b64encode(ssid).decode("ascii")
    pmk_b64 = base64.b64encode(pmk).decode("ascii")

    return f"sha1:4096:{ssid_b64}:{pmk_b64}"


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Convert wpa_supplicant blocks with hex PMKs into hashcat mode 12000 lines."
    )
    parser.add_argument("input", help="Path to wpa_supplicant-style input file")
    parser.add_argument("-o", "--output", help="Output file path (default: stdout)")
    args = parser.parse_args()

    input_path = Path(args.input)
    if not input_path.exists():
        print(f"error: input file not found: {input_path}", file=sys.stderr)
        return 1

    text = input_path.read_text(encoding="utf-8", errors="replace")
    lines = []

    for block in extract_blocks(text):
        line = convert_block(block)
        if line:
            lines.append(line)

    if not lines:
        print(
            "error: no valid network blocks found (requires ssid=\"...\" and 64-hex psk=...)",
            file=sys.stderr,
        )
        return 2

    output_text = "\n".join(lines) + "\n"

    if args.output:
        Path(args.output).write_text(output_text, encoding="utf-8")
    else:
        sys.stdout.write(output_text)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())