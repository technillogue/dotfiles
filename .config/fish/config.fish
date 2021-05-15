# nice ssh's
alias nethack="ssh nethack@xd.cm"
alias edef='sshpass -f $HOME/secrets/edef.pass ssh -t technillogue@spock.edef.eu "tmux attach"'

# radix stuff
set -a -U fish_user_paths /opt/radix/timberland/exec

alias nuke-timberland="sudo scripts/runtime_util.sh -n"
alias nukeinstall-timberland="sudo scripts/runtime_util.sh -n && sudo scripts/runtime_util.sh -i"
alias build-timberland="bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results"
alias buildinstall-timberland="bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i"
alias nukebuildinstall-timberland="sudo scripts/runtime_util.sh -n && bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i"

function rebuild-and-run-timberland-from-scratch
    time begin
    	sudo scripts/runtime_util.sh -n
    	bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results
    	sudo ./scripts/runtime_util.sh -i
    	timberland enable kafka
    	timberland start
    end
    notify-send 'timberland done'
end

function run-timberland-from-scratch
    time begin
    	sudo scripts/runtime_util.sh -n
    	sudo ./scripts/runtime_util.sh -i
    	timberland enable kafka
    	timberland start
    end
    notify-send 'timberland done'
end

# clipboards and pastebins <3
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null
    echo "windows, use clip.exe"
    alias clip="clip.exe"
else
    echo "probably an x server, use xclip -sel clip"
    # when should xsel be used?
    alias clip="xclip -sel clip -in"
end

function getpost
    curl --data-binary @/dev/stdin https://public.getpost.workers.dev | grep share\ link | awk -F': ' '{print $2}' |clip;
end

# misc
set -a -U fish_user_paths $HOME/.local/bin
alias size="du -sh * 2> /dev/null | sort -h"
alias col1="awk {print $2}"
alias col2="awk {print $2}"
