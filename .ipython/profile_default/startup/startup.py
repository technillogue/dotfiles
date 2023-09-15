from importlib import reload
import importlib
import os, sys, json
import subprocess
from pathlib import Path
from typing import Union


def clip(text: str) -> None:
    subprocess.run("fish -c clip", shell=True, input=text.encode())


xclip = clip


def clipout() -> str:
    return subprocess.run("xclip -sel clip -out", shell=True, stdout=-1).stdout


def post(text: str) -> None:
    subprocess.run("fish -c post", shell=True, input=text.encode())


def importpath(path: Union[str, Path]) -> None:
    if isinstance(path, Path):
        module_path = str(path.absolute())
    else:
        module_path = "/home/sylv" + path
    spec = importlib.util.spec_from_file_location("module.name", module_path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
