import sys
import traceback
import inspect
import functools
import pdb as pdb_module
from typing import Optional, Any, Callable
from IPython import embed


def catch_errors(method: Callable) -> Callable:
    # you want to by default only indicate that an internal error has occured
    # require a flag or env var to give the full internal tb
    # re-implement the Pdb default error handling for the default method
    @functools.wraps(method)
    def safe_call(self: pdb_module.Pdb, *args: Any, **kwargs: Any) -> Any:
        try:
            return method(self, *args, **kwargs)
        except:
            self.curframe_locals["__pdb_exc"] = sys.exc_info() # type: ignore
            print("(exc object is in __pdb_exc)")
            traceback.print_exc()

    return safe_call


class PdbExtension(pdb_module.Pdb):
    # we inherit from the Pdb++ object with all of its drop-in replacement hacks
    @catch_errors
    def do_goto_frame(self, arg: str) -> None:
        "go to a frame by number"
        index = int(arg)
        self._select_frame(index) # type: ignore

    do_gf = do_goto_frame

    def do_embed_ipy(self, _: Any = None) -> None:
        "start an IPython shell in the pdb object namespace"
        embed()

    @catch_errors
    def do_debug_line(self, line_arg: str) -> None:
        "try to pdb.run() line_no in the current context. default to prev line"
        lines = inspect.findsource(self.curframe)[0] # type: ignore
        if line_arg:
            line_no = int(line_arg) - 1  # UI indexes from 1; inspect, from 0
        else:
            line_no = max(0, self.curframe.f_lineno - 1) #type: ignore
            print(f"defaulting to {line_no}")
        line = lines[line_no].strip()  # no indent
        print(f"running '{line}'")
        self.do_debug(line) # type: ignore
        # this calls Pdb++.do_debug
        # TODO: check what do_debug ends up doing with namespaces
    # the problem is tha when your do_debug line exits you don't return to your original debugger
    # # the curframe context seems to get fucked up for some reason and you're now
    # # debugging the pdb source
    # # does this happen with breakpoint() recursive debugging? does it happen with pm recursive debugging?
    # # usually what you really want is to debug one line in the current namespace
    # # and ideally update the actual namespace
    # # as a workaround i used to just go one frame higher and call the assertion statement
    # # or evaluation function
    # there you can sort of do the same thing but you can't coneniently exit and come back
    # # you might want to automatically execute the source code line by line if you really wanted to manipulate the AST
    #
    # # finally, also check up on errors raised from recursive debuggers
    #
    # if you quit from the post-recursive debugger you get a spammy _pytest/debugging.py
    # INTERNALERROR which is just a bdb.BdbQuit, so you want to catch that too
    # and then when you quit the pytest session completely, in addition to seeing the
    # printed INTERNALERROR bdb.BdbQuit you get the during-handling _pytest.outcomes.Exit
    #
    # quitting during recursive debugging in a postmoertm also doesn't work
    # it's pretty much designed for breakpoint running 


    @catch_errors
    def default(self, line: str) -> None:
        self.history.append(line)  # type: ignore # for pdb++
        if line[:1] == "!":
            line = line[1:]
        code = compile(line + "\n", "<stdin>", "single")
        save_stdout = sys.stdout
        save_stdin = sys.stdin
        save_displayhook = sys.displayhook
        locals = self.curframe_locals # type: ignore
        globals = self.curframe.f_globals # type: ignore
        ns = {**globals, **locals, "only_globals": globals}
        try:
            sys.stdin = self.stdin #type: ignore
            sys.stdout = self.stdout # type: ignore
            sys.displayhook = self.displayhook #type: ignore
            # normally, we can update or add to globals and it works fine
            # we can add to locals, and pdb will see it, but the
            # existing compiled bytecode will not,
            # and we can update locals, and it will be cached by self.curframe_locals
            # but silently ignored by self.curframe.f_locals
            exec(code, ns)
            del ns["only_globals"]
            if locals is not globals:
                for name in locals.keys() - ns.keys():
                    print(
                        f"you're trying to remove {name} from the local scope. the"
                        "compiled code you're debugging will not see the change"
                    )
                for name in ns.keys() & locals.keys():
                    if ns[name] is not locals[name]:
                        if isinstance(locals[name], list) and isinstance(
                            ns[name], list
                        ):
                            locals[name].clear()
                            locals[name].extend(ns[name])
                        elif isinstance(locals[name], dict) and isinstance(
                            ns[name], dict
                        ):
                            locals[name].clear()
                            locals[name].update(ns)
                        else:
                            print(
                                f"you're trying to redefine '{name}' in local scope. "
                                "setting it in global scope instead (access via "
                                "_only_globals), as the compiled code being debugged "
                                "cannot see your f_locals updates"
                            )
                            globals[name] = ns[name]

                globals.update(
                    {name: value for name, value in ns.items() if name not in locals}
                )
            else:
                globals.update(ns)
        finally:
            sys.stdout = save_stdout
            sys.stdin = save_stdin
            sys.displayhook = save_displayhook


class Config(pdb_module.DefaultConfig): # type: ignore
    editor = "kak"

    def setup(self, pdb_session: pdb_module.Pdb) -> None:
        pdb_session.__class__ = PdbExtension
 
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
#     pdb.run("import test", {}, {})       __builtins__["pdb_session"] = pdb_session
