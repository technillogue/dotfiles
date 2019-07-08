import sys
import traceback
import inspect
import pdb as pdb_module
from typing import Optional, Any
from IPython import embed

# note: you could test this with something like
# import io
# import os
# import textwrap
# @contextlib.contextmanager
# def replace_stdin(replacement):
#     orig = sys.stdin
#     sys.stdin = replacement
#     yield
#     sys.stdin = orig


# def test_setup(capfd, tmpdir):
#     os.chdiri(tmpdir)
#     with open("test.py", "w") as f:
#         f.write("global_val = [None]\ndef foo():\n\tlocal_val =[0]\nfoo()")
#     in_stream = StringIO(textwrap.dedent(
#         """\
#         step # into module
#         step # def foo
#         step # foo()
#         step # --Call-- def foo()
#         step # local_val = [0]j
#         steo # --Return--
#         del local_val
        
#         """
#     ))
#     pdb.run("import test", {}, {})


class Config(pdb_module.DefaultConfig):
    editor = "kak"

    def setup(self, pdb_session: pdb_module.Pdb):
        __builtins__["pdb_session"] = pdb_session
        Pdb = pdb_session.__class__

        def do_embed_ipy(self, arg: Any = None) -> None:
            "start an IPython shell in the pdb object namespace"
            embed()

        Pdb.do_embed_ipy = do_embed_ipy

        def do_exec_line(self, line_no: Optional[str]):
            "try to pdb.run() line_no in the current context. default to prev line"
            try:
                lines = inspect.findsource(self.curframe)[0]
                if not line_no:
                    line_no = max(0, self.curframe.f_lineno - 1)
                    print(f"defaulting to {line_no}")
                else:
                    line_no = int(line_no) - 1  # UI indexes from 1; inspect, from 0
                line = lines[line_no].strip()  # no indent
                print(f"running '{line}'")
                pdb_session.do_debug(line)
                # do_debug does something bizarre with the scopes, or maybe ends up in the Pdb scope
                # a = 0; debug "a = 2"; print(a) gives 0 instead of 2
                # it would be better to do what it does ourselves
            except Exception as exc:
                self.curframe_locals["__pdb_exc"] = sys.exc_info()
                print("(exc object is in __pdb_exc)")
                traceback.print_exc()

        Pdb.do_exec_line = do_exec_line
