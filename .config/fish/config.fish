alias nethack="ssh nethack@xd.cm"
alias edef='sshpass -f $HOME/secrets/edef.pass ssh -t technillogue@spoc.edef.eu "tmux attach"'

alias size="du -sh * 2> /dev/null | sort -h"

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


alias fix-bluetooth="sudo systemctl start bluetooth"
alias clip="tee >(xclip -sel clip -in)"

function getpost
    curl --data-binary @/dev/stdin https://public.getpost.workers.dev | grep share\ link | awk -F': ' '{print $2}' |xclip -sel clip;
end
