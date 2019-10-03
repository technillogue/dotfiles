pip3 install emanate
emanate

wget https://edef.eu/~technillogue/kak.deb > kak
sudo apt-get install kak.deb
git clone https://github.com/andreyorst/plug.kak.git ~/.config/kak/plugins/plug.kak

echo "deb http://ppa.launchpad.net/lazygit-team/release/ubuntu eoan main" | sudo tee -a /etc/apt/sources.list.d/lazygit-eoan.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68CCF87596E97291
sudo apt-get update
sudo apt-get install -y -t testing tmux pinfo ipython3 
sudo apt-get install -y lazygit

pip3 install mypy mypy-extensions typing-extensions typeguard pylint black pdbpp pytest pytest-profiling pytest-pdb pytest-cov pydocstyle
#pip3 install jedi python-language-server pyls-black pyls-mypy
