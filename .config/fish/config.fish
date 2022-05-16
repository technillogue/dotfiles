# nice ssh's
alias nethack="ssh nethack@xd.cm"

# radix stuff
#set -a -U fish_user_paths /opt/radix/timberland/exec
alias nuke-timberland="sudo scripts/runtime_util.sh -n"
alias nukeinstall-timberland="sudo scripts/runtime_util.sh -n && sudo scripts/runtime_util.sh -i"
alias build-timberland="bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results"
alias buildinstall-timberland="bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i"
alias nukebuildinstall-timberland="sudo scripts/runtime_util.sh -n && bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results && sudo ./scripts/runtime_util.sh -i"

function run-timberland-from-scratch
    time begin
    	sudo scripts/runtime_util.sh -n
    	and sudo ./scripts/runtime_util.sh -i
    	and sudo chmod 777 -R /opt/radix
    	and timberland enable minio
    	and timberland disable nginx
    	and timberland start
#    	and timberland enable nginx
    end
    notify-send 'timberland done'
end

function rebuild-and-run-timberland-from-scratch
    time begin
    	bazel build //timberland/jvm:timberland-deb --noremote_upload_local_results --bes_backend=
    	and run-timberland-from-scratch
    end
end

# clipboards and pastebins <3
set clip_alias_exists (alias | grep clip)
#if test -z clip_alias_exists # zero matches
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null 
 #       echo "windows, use clip.exe"
        alias clip="clip.exe"
    else
  #      echo "probably an x server, use xclip -sel clip"
        # when should xsel be used?
        function clip          
            xclip -sel clip -in
            xclip -sel clip -out
        end
    end
#end
    
function getpost
    curl --data-binary @/dev/stdin https://public.getpost.workers.dev | grep share\ link | awk -F': ' '{print $2}' |clip;
end

# misc
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/go/bin  $HOME/.fly/bin
alias size="du -sh * 2> /dev/null | sort -h"
alias col1='awk {print \$2}'
alias col2='awk {print \$2}'

alias notouchpad='xinput set-prop 12 "Device Enabled" 0'
alias yestouchpad='xinput set-prop 12 "Device Enabled" 1'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME';
alias fishconfig="kak ~/.config/fish/config.fish ~/.bash_aliases ~/.bashrc && source ~/.config/fish/config.fish"

# python
alias pip3.9="python3.9 -m pip"
function pycheck
    python3.9 -m pylint $argv &
    python3.9 -m mypy $argv
end


alias mob="curl -s localhost:9090/wallet -X POST -H 'Content-type: application/json' -d"
alias ilia "ssh -i ~/.ssh/wyrt_id_rsa -p 8009 name@24.247.146.161"

#if -z ~/dotfiles/google-cloud-sdk/path.fish.inc;
#    source ~/dotfiles/google-cloud-sdk/path.fish.inc;
#end
