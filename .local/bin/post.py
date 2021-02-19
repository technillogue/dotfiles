#!/usr/bin/python3
import sys
import requests
import re
import subprocess

try:
    data = open(sys.argv[1]).read()
except (FileNotFoundError, IndexError):
    data = sys.stdin.read()

r = requests.post("https://getpost.bitsandpieces.io/post", data = data)
link = re.search(r"https://getpost.*", r.text).group(0)

subprocess.run(["xclip", "-sel", "clipboard"], input=link.encode("utf-8"))
print(f"copied {link}")
