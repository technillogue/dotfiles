pip3 install emanate
emanate

sudo apt install -t testing gcc libncursesw5-dev pkg-config
cd $HOME
git clone https://github.com/mawww/kakoune.git && cd kakoune/src
make
PREFIX=$HOME/.local make install
cd ../..
rm -rf kakoune

git clone https://github.com/andreyorst/plug.kak.git ~/.config/kak/plugins/plug.kak

echo "deb http://ppa.launchpad.net/lazygit-team/release/ubuntu eoan main" | sudo tee -a /etc/apt/sources.list.d/lazygit-eoan.list
sudo apt-get update
sudo apt-get install -t testing tmux pinfo python3-pip ipython3 
sudo apt-get install lazygit

pip3 install mypy mypy-extensions typing-extensions typeguard pylint black pdbpp pytest pytest-profiling pytest-pdb pytest-cov pydocstyle


pip3 install jedi python-language-server pyls-black pyls-mypy
