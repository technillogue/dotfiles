echo "deb http://ppa.launchpad.net/lazygit-team/release/ubuntu eoan main" | sudo tee -a /etc/apt/sources.list.d/lazygit-eoan.list
sudo apt-get update
sudo apt-get install -t testing tmux pinfo python3-pip ipython3 
sudo apt-get install lazygit

pip3 install mypy mypy-extensions typing-extensions pylint black pdbpp pytest pytest-profiling pytest-pdb pytest-cov pydocstyle pyenchant

sudo apt-get install -t testing kakoune
pip3 install jedi python-language-server pyls-black pyls-mypy

ln -s $HOME/dev-env/kakrc $HOME/.config/kak/
ln -s $HOME/dev-env/.bash_aliases $HOME
ln -s $HOME/dev-env/.bashrc $HOME
ln -s $HOME/dev-env/.mypy.ini $HOME
ln -s $HOME/dev-env/.pdbrc.py $HOME
ln -s $HOME/dev-env/.pylintrc $HOME
ln -s $HOME/dev-env/.tmux.conf $HOME
