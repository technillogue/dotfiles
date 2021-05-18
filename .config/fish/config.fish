alias nethack="ssh nethack@xd.cm"
alias edef='sshpass -f $HOME/secrets/edef.pass ssh -t technillogue@spock.edef.eu "tmux attach"'
alias earnest='sshpass -f $HOME/secrets/earnest.pass ssh -t earnest@192.168.1.154 "tmux attach"'
alias demo='ssh -i $HOME/.ssh/sylvie-dev.pem ubuntu@18.222.138.151'
alias newwhalefarm="ssh -i ~/.ssh/sylvie-ci-dev.pem ubuntu@34.229.89.110"


alias size="du -sh * 2> /dev/null | sort -h"

alias nuke-timberland="sudo scripts/runtime_util.sh -n"
alias nukeinstall-timberland="sudo scripts/runtime_util.sh -n && sudo scripts/runtime_util.sh -i"
alias build-timberland="bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results"
alias buildinstall-timberland="bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i"
alias nukebuildinstall-timberland="sudo scripts/runtime_util.sh -n && bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i"

function run-timberland-from-scratch
    time begin
    	sudo scripts/runtime_util.sh -n
    	and sudo ./scripts/runtime_util.sh -i
    	and timberland enable noprompts
    	and timberland start
    end
    notify-send 'timberland done'
end

function rebuild-and-run-timberland-from-scratch
    time begin
    	sudo scripts/runtime_util.sh -n
    	and bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results --bes_backend=
    	and sudo ./scripts/runtime_util.sh -i
    	and timberland enable noprompts
    	and timberland start
    end
    notify-send 'timberland done'
end


alias clip="xclip -sel clip -in"

function getpost
    curl --data-binary @/dev/stdin https://public.getpost.workers.dev | grep share\ link | awk -F': ' '{print $2}' |xclip -sel clip;
end

set -a -U fish_user_paths /opt/radix/timberland/exec
set -U demo_ip "18.222.138.151"
set -U farm_ip "34.229.89.110"
set -U NEXUS_USERNAME admin
set -U NEXUS_PASSWORD radix789
