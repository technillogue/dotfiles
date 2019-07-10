echo "deb http://ppa.launchpad.net/lazygit-team/release/ubuntu eoan main" | sudo tee -a /etc/apt/sources.list.d/lazygit-eoan.list
sudo apt-get update
sudo apt-get install -t testing tmux pinfo python3-pip ipython3 
sudo apt-get install lazygit

pip3 install mypy mypy-extensions typing-extensions pylint black pdbpp pytest pytest-profiling pytest-pdb pytest-cov pydocstyle pyenchant

sudo apt-get install -t testing kakoune
pip3 install jedi python-language-server pyls-black pyls-mypy

ln -s .pylintrc $HOME/.pylintrc
ln -s .bash_aliases $HOME
ln -s .bashrc $HOME
ln -s .mypy.ini $HOME
ln -s .pdbrc.py $HOME
ln -s .pylintrc $HOME
ln -s .tmux.conf $HOME
ln -s kakrc $HOME/.config/kak/
