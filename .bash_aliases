alias fuck='sudo !!';

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME';

alias dx='sshpass -f $HOME/secrets/dx.pass ssh sylvie@dequis.org'

alias edef='sshpass -f $HOME/secrets/edef.pass ssh -t technillogue@spock.edef.eu "tmux attach"'
alias edefmosh='sshpass -f $HOME/secrets/edef.pass mosh technillogue@spock.edef.eu'
alias edefscp='sshpass -f $HOME/secrets/edef.pass scp'
edefpush (){
    edefscp "$1" "technillogue@spock.edef.eu:`realpath --relative-to=$HOME $1`";
}

alias nethack="ssh nethack@xd.cm"

alias vi_real="/usr/bin/vi"
alias vi="kak"
alias pip="pip3"
alias pylint="python3 -m pylint"
alias pytest="python3 -m pytest"
check_py (){
	pylint $1;
	mypy $1;
    pytest $1/..;
}

git_push (){
	git add -u;
	git commit -m "$1";
	git push origin master
}

alias size="du -sh * 2> /dev/null | sort -h"
alias ipython="python3 -m IPython"
alias ipy="python3 -m IPython"
alias python="python3"
alias tor-browser="pushd $HOME/apps/tor-browser_en-US; ./start-tor-browser.desktop; popd;"
