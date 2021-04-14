alias fuck='sudo !!';

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME';

alias dx='sshpass -f $HOME/secrets/dx.pass ssh sylvie@dequis.org'

alias edef='sshpass -f $HOME/secrets/edef.pass ssh -t technillogue@spock.edef.eu "tmux attach"'
alias edefmosh='sshpass -f $HOME/secrets/edef.pass mosh technillogue@spock.edef.eu'
alias edefscp='sshpass -f $HOME/secrets/edef.pass scp'

alias nethack="ssh nethack@xd.cm"

alias vi_real="/usr/bin/vi"
alias vi="kak"
alias pip="python3.9 -m pip"
alias pylint="python3.9 -m pylint"
alias pytest="python3.9 -m pytest"

alias size="du -sh * 2> /dev/null | sort -h"
alias ipython="python3.9 -m IPython"
alias ipy="python3.9 -m IPython"
alias python="python3.9"
alias py8="python3.8"
alias tor-browser="pushd $HOME/apps/tor-browser_en-US; ./start-tor-browser.desktop; popd;"

alias nuke-timberland="sudo scripts/runtime_util.sh -n"
alias nukeinstall-timberland="sudo scripts/runtime_util.sh -n && sudo scripts/runtime_util.sh -i"
alias build-timberland="bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results"
alias buildinstall-timberland="bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i"
alias nukebuildinstall-timberland="sudo scripts/runtime_util.sh -n && bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i"

alias rebuild-and-run-timberland-from-scratch="time (sudo scripts/runtime_util.sh -n && bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i && timberland disable runtime && timberland enable kafka && timberland start); notify-send 'timberland done'"
alias run-timberland-from-scratch="time (sudo scripts/runtime_util.sh -n && sudo ./scripts/runtime_util.sh -i && timberland disable runtime && timberland enable kafka && timberland start); notify-send 'timberland done'"

alias clip="tee >(xclip -sel clip -in)"

function getpost() {
    curl --data-binary @/dev/stdin https://public.getpost.workers.dev | grep share\ link | awk -F': ' '{print $2}' |xclip -sel clip;
}
